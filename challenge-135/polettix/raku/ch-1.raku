#!/usr/bin/env raku
use v6;
sub middle-three-digits (Int:D $x is copy) {
   $x = -$x if $x < 0;
   my $l = $x.chars;
   die "too short\n" if $l < 3;
   die "even number of digits\n" if $l %% 2;
   $x.substr(($l - 3) / 2, 3);
}
put middle-three-digits((@*ARGS[0] || 1234567).Int);
