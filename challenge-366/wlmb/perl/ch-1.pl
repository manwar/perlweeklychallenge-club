#!/usr/bin/env perl
# Perl weekly challenge 366
# Task 1:  Count Prefixes
#
# See https://wlmb.github.io/2026/03/27/PWC366/#task-1-count-prefixes
use v5.36;
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 A0 S0 A1 S1...
    where the string An is a comma separated list of possible
    prefixes. The result is the number of prefixes of An that
    match the string Sn
    FIN
for my($array, $string)(@ARGV){
    say"$array; $string -> ",0+grep{$string=~/^$_/} split /,\s*/, $array;
}
