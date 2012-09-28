shared_context "suites sample" do
  let(:suites) do
    [
        {
            "id" => "0",
            "name" => "Suite name",
            "type" => "suite",
            "children" => [
                {
                    "id" => "0",
                    "name" => "Spec name",
                    "type" => "spec",
                    "children" => []
                },
                {
                    "id" => "1",
                    "name" => "Other spec name",
                    "type" => "spec",
                    "children" => []
                }
            ]
        },
        {
            "id" => "1",
            "name" => "Other suite name",
            "type" => "suite",
            "children" => [
                {
                    "id" => "2",
                    "name" => "Third spec name",
                    "type" => "spec",
                    "children" => []
                }
            ]
        }
    ]
  end
end

shared_context "suite result sample" do

  let(:suite_results) do
    {
        "0"=> {
            "result"=>"passed",
            "messages"=>[
                {
                    "passed"=>"true",
                    "type"=>"expect",
                    "message"=>"Passed.",
                    "trace"=>{}
                }
            ]
        },
        "1"=> {
            "result"=>"passed",
            "messages"=>[
                {
                    "passed"=>"true",
                    "type"=>"expect",
                    "message"=>"Passed.",
                    "trace"=>{}
                }
            ]
        },
        "2"=> {
            "result"=>"failed",
            "messages"=>[
                {
                    "passed"=>"false",
                    "type"=>"expect",
                    "message"=>"Failed for some reason",
                    "trace"=>{}
                }
            ]
        }
    }
  end
end