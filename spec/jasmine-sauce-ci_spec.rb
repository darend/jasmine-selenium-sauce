require_relative 'spec_helper'
require_relative 'vcr_helper'
require 'jasmine-sauce-ci'
require 'reporter_fake'

describe Jasmine::Sauce::CI::Main do

  let(:reporter) { ReporterFake.new }
  subject { Jasmine::Sauce::CI::Main.run(reporter) }

  describe "#run" do

    after do
      ENV.delete('SAUCELABS_URL')
      ENV.delete('JASMINE_URL')
      ENV.delete('SAUCE_BROWSER')
    end

    context "when there are no failures" do
      use_vcr_cassette 'jasmine_success', record: :none
      before do
        ENV['SAUCELABS_URL'] = 'http://username:password@ondemand.saucelabs.com:80/wd/hub'
        ENV['JASMINE_URL'] = 'http://jasmine.server.com/jasmine'
        ENV['SAUCE_BROWSER'] = 'chrome'
      end

      describe "passing tests" do
        it { subject[:passed].should eq([0,1,2]) }
      end
      describe "failing tests" do
        it { subject[:failed].should be_empty }
      end
    end

    context "when there are failures" do
      use_vcr_cassette 'jasmine_failures', record: :none
      before do
        ENV['SAUCELABS_URL'] = 'http://username:password@ondemand.saucelabs.com:80/wd/hub'
        ENV['JASMINE_URL'] = 'http://jasmine.server.com/jasmine'
        ENV['SAUCE_BROWSER'] = 'chrome'
      end

      describe "passing tests" do
        it { subject[:passed].should eq([0,2]) }
      end
      describe "failing tests" do
        it { subject[:failed].should eq([1]) }
      end
    end

  end
end