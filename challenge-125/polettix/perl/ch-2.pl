#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my $diameter = 0;
my $tree =
   node(1,
      node(2, node(3), node(4)),
      node(5, node(6), node(7, node(8, node(9)), node(10)))
   );

say scalar visit_for_diameter($tree); # should be 6
$tree = node(0, $tree);
say scalar visit_for_diameter($tree); # should still be 6


# helper for building the node of a tree. A leaf node is produced by
# default, putting the left and right sub-trees to undef. A node is
# represented by an array reference with one label and two children.
sub node ($label, $left = undef, $right = undef) {
   return [$label, $left, $right];
}

sub visit_for_diameter ($root) {
   die "Ceci n'est pas une arbre\n" unless $root;

   # this keeps the length of the best diameter candidate passing through
   # the $root node itself
   my $subtree = 0;

   # this keeps the longest sub-leg starting from $root
   my $longest = 0;

   # this keeps the best diamater as found in some descendant but not
   # through $root
   my $best = 0;

   # iterate over the left and right sub-trees
   for my $children ($root->@[1, 2]) {

      # don't bother following dead ends
      next unless $children;

      # this gets the recursive sub-call, receiving the best diameter and
      # the longest leg length
      my ($c_best, $c_length) = visit_for_diameter($children);

      # keep the best between the left and the right sub-tree
      $best = $c_best if $c_best > $best;

      # the actual leg length from $root is one more step because we have
      # to reach the child with one step
      ++$c_length;

      # keep the best sub-tree length
      $longest = $c_length if $c_length > $longest;

      # anyway, the best diameter passing through $root has to take into
      # account the length of the leg
      $subtree += $c_length;
   }

   # the longest sub-tree length is established, but the best will have to
   # be established by comparing the best from the descendants and the
   # overall diameter passing through $root (i.e. $subtree)
   $best = $subtree if $subtree > $best;

   # return only the $best diameter in scalar context, and both in list
   # context so that we can properly recurse
   return $best unless wantarray;
   return ($best, $longest);
}
