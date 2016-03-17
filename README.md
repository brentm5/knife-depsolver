## knife-depsolver

Knife plugin that uses Chef Server to calculate cookbook dependencies for a given run_list.

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

