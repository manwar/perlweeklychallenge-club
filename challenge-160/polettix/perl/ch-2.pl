#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my @n = @ARGV ? @ARGV : (1, 3, 5, 7, 9);
say equilibrium_index(@n);

sub equilibrium_index (@n) {
   my $i_lo = 0;
   my $i_hi = $#n;
   my $diff = 0;
   $diff += ($diff <= 0 ? $n[$i_lo++] : -$n[$i_hi--]) while $i_lo < $i_hi;
   return @n && $diff == 0 ? $i_lo : -1;
}
