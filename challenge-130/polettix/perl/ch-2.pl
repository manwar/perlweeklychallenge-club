#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub check_bst ($root) {
   state $checker = sub ($node) {
      return 1 unless $node;
      my $key = $node->{key};
      my ($lsub, $lmin, $lmax) = __SUB__->($node->{left});
      return 0 unless $lsub;
      ($lmin, $lmax) = ($key, $key - 1) unless defined $lmin;
      my ($rsub, $rmin, $rmax) = __SUB__->($node->{right});
      return 0 unless $rsub;
      ($rmin, $rmax) = ($key + 1, $key) unless defined $rmin;
      return 0 if $key < $lmax || $key > $rmin;
      return (1, $lmin, $rmax);
   };
   return ($checker->($root))[0];
}

sub n ($k, $l = undef, $r = undef) {{key => $k, left => $l, right => $r}}

say check_bst(n(8, n(5, n(4), n(6)), n(9)));
say check_bst(n(5, n(4, n(3), n(6)), n(7)));
