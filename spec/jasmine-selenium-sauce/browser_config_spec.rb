require 'spec_helper'
require 'config_fixtures'
require 'browser_config'

describe Jasmine::Sauce::CI::BrowserConfig do

  after do
    ENV.delete('JASMINE_URL')
    ENV.delete('LOCAL_BROWSER')
  end

  describe "#validate" do
    subject { Jasmine::Sauce::CI::BrowserConfig.new.validate }

    context "when valid" do
      before do
        ENV['JASMINE_URL'] = 'jasmine'
        ENV['LOCAL_BROWSER'] = 'browser'
      end
      specify { expect { subject }.not_to raise_error  }
    end

    context "when jasmine url is not set" do
      before do
        ENV['LOCAL_BROWSER'] = 'browser'
      end
      specify { expect { subject }.to raise_error(ArgumentError)  }
    end

    context "when browser is not set" do
      before do
        ENV['JASMINE_URL'] = 'jasmine'
      end
      specify { expect { subject }.to raise_error(ArgumentError)  }
    end
  end

  include_context "jasmine server url" do
    subject { Jasmine::Sauce::CI::BrowserConfig.new }
  end
end