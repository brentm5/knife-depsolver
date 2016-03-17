# This `knife exec` script gets a node's expanded run_list with version
# constraints for a specified environment.

# Then it POSTs the expanded run_list to the environment's cookbook_versions
# endpoint to retrieve a list of dependency resolved cookbooks that meet all
# specified version constraints.

require 'chef/knife'
require 'chef/run_list/run_list_expansion'
require 'chef/run_list/run_list_item'

class Chef
  class Knife
    class Depsolver < Knife
      deps do
      end

      banner 'knife depsolver RUN_LIST'

      option :node,
             short: '-n',
             long: '--node NAME',
             description: 'Use the run list from a given node'

      def run
        cookbook_versions = {}

        run_list = name_args.map {|item| item.to_s.split(/,/) }.flatten.each{|item| item.strip! }
        run_list.delete_if {|item| item.empty? }

        if config[:node]
          node = Chef::Node.load(config[:node])
        else
          node = Chef::Node.new
          node.name('depsolver-tmp-node')
          run_list.each do |arg|
            node.run_list.add(arg)
          end
        end

        environment = config[:environment]
        environment ||= node.chef_environment

        run_list_expansion = node.expand!
        expanded_run_list_with_versions = run_list_expansion.recipes.with_version_constraints_strings

        begin
          depsolver_start_time = Time.now
          ckbks = rest.post_rest("environments/" + environment + "/cookbook_versions", { "run_list" => expanded_run_list_with_versions })
          depsolver_finish_time = Time.now
        rescue
        end

        depsolver_results = {}
        ckbks.each do |name, ckbk|
          version = ckbk.is_a?(Hash) ? ckbk['version'] : ckbk.version
          depsolver_results[name] = version
        end

        results = {
          node: node.name,
          environment: environment,
          environment_cookbook_versions: Chef::Environment.load(environment).cookbook_versions,
          run_list: node.run_list,
          expanded_run_list: expanded_run_list_with_versions,
          depsolver_results: depsolver_results,
          depsolver_cookbook_count: depsolver_results.count,
          depsolver_elapsed_ms: ((depsolver_finish_time - depsolver_start_time) * 1000).to_i
        }

        msg(JSON.pretty_generate(results))
      end
    end
  end
end
