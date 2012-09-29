
shared_examples_for "selenium driver" do
  describe "#connect" do
    let(:url) { "http://jasmine.server.url/jasmine" }
    let(:navigator) { double("SeleniumNavigator") }
    subject { under_test.connect(url) }
    before do
      driver.should_receive(:navigate).and_return(navigator)
      navigator.should_receive(:to).with(url)
    end

    specify { expect { subject }.not_to raise_error }
  end

  describe "#disconnect" do
    subject { under_test.disconnect }
    before do
      driver.should_receive(:quit)
    end

    specify { expect { subject }.not_to raise_error }
  end

  describe "#evaluate_js" do
    let(:script) { "the javascript" }
    subject { under_test.evaluate_js(script) }
    before do
      driver.should_receive(:execute_script).and_return(script_result)
    end

    context "when simple result" do
      let(:script_result) { "true" }
      it { should be_true }
    end

    context "when json result" do
      include_context "suites sample"
      let(:script_result) { suites.to_json }
      it { should eq(JSON.parse(script_result)) }
    end
  end
end