require 'spec_helper'
require 'config_fixtures'
require 'sauce_config'
require 'local_sauce_config'

describe Jasmine::Sauce::CI::LocalSauceConfig do

  after do
    ENV.delete('SAUCELABS_URL')
    ENV.delete('JASMINE_PORT')
    ENV.delete('SAUCE_BROWSER')
  end

  describe "#validate" do
    subject { Jasmine::Sauce::CI::LocalSauceConfig.new.validate }

    context "when valid" do
      before do
        ENV['SAUCELABS_URL'] = 'sauce'
        ENV['JASMINE_PORT'] = 'port'
        ENV['SAUCE_BROWSER'] = 'browser'
      end
      specify { expect { subject }.not_to raise_error  }
    end

    context "when saucelabs url is not set" do
      before do
        ENV['JASMINE_PORT'] = 'port'
        ENV['SAUCE_BROWSER'] = 'browser'
      end
      specify { expect { subject }.to raise_error(ArgumentError)  }
    end

    context "when jasmine url is not set" do
      before do
        ENV['SAUCELABS_URL'] = 'sauce'
        ENV['SAUCE_BROWSER'] = 'browser'
      end
      specify { expect { subject }.to raise_error(ArgumentError)  }
    end

    context "when browser is not set" do
      before do
        ENV['SAUCELABS_URL'] = 'sauce'
        ENV['JASMINE_PORT'] = 'port'
      end
      specify { expect { subject }.to raise_error(ArgumentError)  }
    end
  end

  describe "#jasmine_server_port" do
    let(:port) { "9843" }
    before { ENV['JASMINE_PORT'] = port }
    after { ENV.delete('JASMINE_PORT') }
    its(:jasmine_server_port) { should eq(port)}
  end

  it_behaves_like 'sauce config' do
    let(:under_test) { Jasmine::Sauce::CI::LocalSauceConfig.new }
  end
end