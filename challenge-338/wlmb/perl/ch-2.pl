#!/usr/bin/env perl
# Perl weekly challenge 338
# Task 2:  Max Distance
#
# See https://wlmb.github.io/2025/09/07/PWC338/#task-2-max-distance
use v5.36;
use feature qw(try);
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 X1 Y1 X2 Y2...
    to find the maximum distance between the elements of array Xi and Yi.
    The inputs Xi and Yi are strings that may be parsed by ~PDL~ as arrays
    of the form "[z0 z1...]"
    FIN
for my ($x, $y)(@ARGV){
    try {
        # initialize $p and $q with the min and max of each input
        my ($p, $q)=map {pdl(pdl($_)->minmax)} ($x,$y);
        # reverse one array to subtract minimum from maximum and maximum from minimum
        my $result = ($p-$q(-1:0))->abs->max;
        say "$x, $y -> ", $result;
    }
    catch($e){ warn $e }
}
