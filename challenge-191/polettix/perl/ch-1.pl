#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say twice_largest(@ARGV);

sub twice_largest (@list) {
   return -1 unless @list > 0;
   return 1 unless @list > 1;
   my ($top, $next) = reverse sort { $a <=> $b } @list;
   return ($top >= 2 * $next) ? 1 : -1;
}
