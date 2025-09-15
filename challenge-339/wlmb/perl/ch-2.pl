#!/usr/bin/env perl
# Perl weekly challenge 339
# Task 2:  Peak Point
#
# See https://wlmb.github.io/2025/09/15/PWC339/#task-2-peak-point
use v5.36;
use feature qw(try);
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 G0 G1...
    to find the maximum value of the cumulative sums of the gains
    in arrays G0, G1... Each argument is a string of the form "[g0 g1...]"
    that may be understood by PDL, where gn is the gain in step n.
    FIN
for(@ARGV){
    try{
	say "$_ -> ", append(0,pdl($_))->cumusumover->max
    }
    catch($e){
	warn $e;
    }
}
