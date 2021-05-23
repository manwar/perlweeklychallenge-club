#!/usr/bin/env raku
use v6;

sub recreate-binary-tree ($tree is rw) {
   my $sum = 0;
   sub accumulate ($n) { $sum += $n<value> };
   sub update     ($n) { $n<value> = $sum - $n<value> };
   for &accumulate, &update -> $cb {
      my @queue = $tree,;
      while (@queue) {
         my $node = @queue.shift // next;
         $cb($node);
         next unless $node<children>:exists;
         @queue.push($node<children>.Slip);
      }
   }
   return $tree;   
}

sub node ($value is copy, $left = Nil, $right = Nil) {
   my $pleft = $left.gist;
   my $pright = $right.gist;
   my $retval = { value => $value };
   $retval<children> = $left.defined || $right.defined
      ?? ($left, $right) !! ();
   return $retval;
}

sub printout ($root, $indent = 0) {
   my $value = $root.defined ?? $root<value> !! '';
   say '  ' x $indent, "<$value>";
   return unless $root;
   printout($_, $indent + 1) for $root<children>.all;
}

#     1
#    / \
#   2   3
#  /   / \
# 4   5   6
#  \
#   7
my $T =
  node(1, node(2, node(4, Nil, node(7))), node(3, node(5), node(6)));
printout(recreate-binary-tree($T));
