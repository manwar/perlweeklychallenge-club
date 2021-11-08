#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Time::Local 'timegm';

sub dow ($y, $m, $d) { (gmtime(timegm(1, 1, 1, $d, --$m, $y)))[6] }
sub is_long_year ($y) {
   my $dow = dow($y, 1, 1);
   return $dow == 4 || $dow == 3 && dow($y, 12, 31) == 4;
} ## end sub is_long_year ($y)

my @longs = grep { is_long_year($_) } (1900 .. 2100);
while (@longs > 0) {
   my @slice = splice @longs, 0, 5;
   say join ', ', @slice, (@slice == 5 ? '' : ());
}
