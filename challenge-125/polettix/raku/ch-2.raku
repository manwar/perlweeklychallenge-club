#!/usr/bin/env raku
use v6;

sub node ($L, $left = Nil, $right = Nil) { return ($L, $left, $right) }

sub visit-for-diameter ($root) {
   die "Ceci n'est pas une arbre\n" unless $root;

   my ($subtree, $longest, $best) = (0, 0, 0);
   for $root[1, 2] -> $children {
      next unless $children;
      my ($c_best, $c_length) = visit-for-diameter($children);
      $best = $c_best if $c_best > $best;
      ++$c_length;
      $longest = $c_length if $c_length > $longest;
      $subtree += $c_length;
   }
   $best = $subtree if $subtree > $best;
   return ($best, $longest);
}

sub MAIN {
   my $tree =
      node(1,
         node(2, node(3), node(4)),
         node(5, node(6), node(7, node(8, node(9)), node(10)))
      );

   put visit-for-diameter($tree)[0]; # should be 6
   $tree = node(0, $tree);
   put visit-for-diameter($tree)[0]; # should still be 6
}
