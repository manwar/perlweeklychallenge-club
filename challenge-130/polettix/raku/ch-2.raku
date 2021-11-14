#!/usr/bin/env raku
use v6;

sub check-bst ($root) {
   my sub checker ($node --> Array()) {
      return 1 unless $node;
      my ($key, $left, $right) = $node<key left right>;
      my ($lsub, $lmin, $lmax) = checker($left);
      return 0 unless $lsub;
      ($lmin, $lmax) = ($key, $key - 1) unless defined $lmin;
      my ($rsub, $rmin, $rmax) = checker($right);
      return 0 unless $rsub;
      ($rmin, $rmax) = ($key + 1, $key) unless defined $rmin;
      return 0 if $key < $lmax || $key > $rmin;
      return (1, $lmin, $rmax);
   }
   return checker($root)[0];
}

sub n ($k, $l = Nil, $r = Nil) {(key => $k, left => $l, right => $r).hash}

put check-bst(n(8, n(5, n(4), n(6)), n(9)));
put check-bst(n(5, n(4, n(3), n(6)), n(7)));
