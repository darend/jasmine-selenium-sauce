namespace :jasmine do

  desc "Run Jasmine via SauceLabs"
  task :sauce do
    require "rspec/core/rake_task"

    RSpec::Core::RakeTask.new(:jasmine_sauce_runner) do |t|
      t.rspec_opts = ["--colour", "--format", ENV['JASMINE_SPEC_FORMAT'] || "progress"]
      t.verbose = true
      runner_path = File.expand_path(File.join(File.dirname(__FILE__), "rake_runner.rb"))
      t.pattern = [runner_path]
    end

    Rake::Task["jasmine_sauce_runner"].invoke
  end
end
