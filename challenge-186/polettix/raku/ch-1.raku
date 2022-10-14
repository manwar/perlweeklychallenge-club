#!/usr/bin/env raku
use v6;
sub MAIN {
   my @a = <1 2 3>;
   my @b = <a b c>;
   zip(@a, @b).say;
   zip(@b, @a).say;
}

sub zip (@a, @b) { (@a Z @b).flat }
