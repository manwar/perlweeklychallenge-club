#!/usr/bin/env raku
use v6;
sub MAIN (Str:D $member = '4/3') {
   my $parent = parent-of($member);
   my $grandparent = parent-of($parent);
   put "parent = '$parent' and grandparent = '$grandparent'";
}

sub parent-of ($frac) {
   my ($n, $d) = $frac.split: '/';
   ($n < $d ?? ($n, $d - $n) !! ($n - $d, $d)).join: '/';
}
