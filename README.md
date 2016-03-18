## knife-depsolver

Knife plugin that uses Chef Server to calculate cookbook dependencies for a given run_list.

Some features of knife-depsolver:

1. JSON output for easy parsing
2. API error handling provides very helpful information
3. Accepts cookbook version constraints directly in the run_list
4. Useful information such as environment cookbook version constraints, expanded run_list and elapsed time for depsolver request
5. Ordering of depsolver results is maintained rather than sorted so you see what really gets passed to the chef-client

### Install

```
chef gem install knife-depsolver
```

### Usage

Find the depsolver solution for an arbitrary run_list.
Specifying recipes and even cookbook version constraints is allowed.

```
knife depsolver 'cookbook-B,cookbook-A::foo@3.1.4,cookbook-R'
```

Find the depsolver solution for an arbitrary run_list using a specific environment's cookbook version constraints.
Specifying recipes and even cookbook version constraints is allowed.

```
knife depsolver -E production 'cookbook-B,cookbook-A::foo@3.1.4,cookbook-R'
```

Find the depsolver solution for a node's run_list.

```
knife depsolver -n demo-node
```

Find the depsolver solution for a node's run_list using a specific environment's cookbook version constraints.

```
knife depsolver -E production -n demo-node
```

