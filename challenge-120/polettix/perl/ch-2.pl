#!/usr/bin/env perl
use v5.24;
sub clock_angle {
   my ($hrs, $mins) = split m{:}mxs, $_[0];
   my $angle = ($mins * 6) - (($hrs % 12) * 30 + $mins / 2);
   $angle = -$angle if $angle < 0;
   return $angle <= 180 ? $angle : 360 - $angle;
}
say clock_angle($_) . ' degree' for @ARGV ? @ARGV : qw< 03:10 04:00 >;
