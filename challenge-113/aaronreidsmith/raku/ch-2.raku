#!/usr/bin/env raku

subset NodeValue of Str where { $_ ~~ /^<digit>$/ || $_ eq 'Nil' }

class Node {
  has Node $.left  is rw = Nil;
  has Node $.right is rw = Nil;
  has Int  $.value is rw = 0;
}

# Adapted from https://rosettacode.org/wiki/Visualize_a_tree#Raku
sub format-tree(
  Node $root,
  Str :$indent = '',
  :@mid = ('├─', '│ '),
  :@end = ('└─', '  ')
) returns Str {
  sub visit(Node $node, *@pre) {
    with $node {
      |gather {
        take @pre[0] ~ $node.value;
        my @children = ($node.right, $node.left).grep(*.defined);
        my $end = @children.end;
        for @children.kv -> $_, $child {
          when $end { take visit($child, (@pre[1] X~ @end)) }
          default   { take visit($child, (@pre[1] X~ @mid)) }
        }
      }
    }
  }
  visit($root, $indent xx 2).join("\n");
}

sub build-tree(@array, $root is copy = Nil, Int $i = 0) returns Node {
  if $i < @array.elems && @array[$i] ne 'Nil' {
    $root       = Node.new(value => @array[$i].Int);
    $root.left  = build-tree(@array, $root.left, 2 * $i + 1);
    $root.right = build-tree(@array, $root.right, 2 * $i + 2);
  }
  $root;
}

sub challenge(Node $root is copy, @values = ()) returns Node {
  sub extract-values(Node $root) returns Positional {
    with $root {
      ($root.value, |extract-values($root.left), |extract-values($root.right));
    }
  }

  with $root {
    my @node-values = @values.elems > 0 ?? @values !! extract-values($root);
    $root.value = @node-values.grep(* != $root.value).sum;
    challenge($root.left, @node-values);
    challenge($root.right, @node-values);
  }
  $root;
}

multi sub MAIN(*@nodes where all(@nodes) ~~ NodeValue) {
  my $root = build-tree(@nodes);
  say format-tree(challenge($root));
}

multi sub MAIN(Bool :$test) {
  use Test;

  my $input-tree = build-tree(<1 2 3 4 Nil 5 6 Nil 7 Nil Nil>);
  my $expected-tree = build-tree(<27 26 25 24 Nil 23 22 Nil 21 Nil Nil>);

  is(format-tree(challenge($input-tree)), format-tree($expected-tree));

  done-testing;
}
