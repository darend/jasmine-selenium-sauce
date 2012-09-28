
class ReporterFake

  def report(jasmine_results)
    results = { passed: [], failed: []}
    jasmine_results.suites.each do |suite|
      child_results = process_children(suite["children"], jasmine_results)
      results[:passed].concat(child_results[:passed]) if child_results[:passed]
      results[:failed].concat(child_results[:failed]) if child_results[:failed]
    end
    results
  end

  def process_children(children, jasmine_results)
    results = { passed: [], failed: []}
    children.each do |node|
      type = node["type"]
      if type == "suite"
        child_results = process_children(node["children"], jasmine_results)
        results[:passed].concat(child_results[:passed]) if child_results[:passed]
        results[:failed].concat(child_results[:failed]) if child_results[:failed]
      elsif type == "spec"
        spec_result = jasmine_results.for_spec_id(node["id"].to_s)
        results[:passed] << node["id"] if spec_result["result"] == "passed"
        results[:failed] << node["id"] if spec_result["result"] == "failed"
      end
    end
    results
  end

end