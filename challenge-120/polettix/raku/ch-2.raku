#!/usr/bin/env raku
use v6;
sub clock-angle ($t) {
   my ($hrs, $mins) = $t.split(/\:/);
   my $angle = ($mins * 6) - (($hrs % 12) * 30 + $mins / 2);
   $angle = -$angle if $angle < 0;
   return $angle <= 180 ?? $angle !! 360 - $angle;
}
put "{clock-angle($_)} degree" for @*ARGS ?? @*ARGS !! qw< 03:10 04:00 >;
