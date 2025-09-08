#!/usr/bin/env perl
# Perl weekly challenge 338
# Task 1:  Highest Row
#
# See https://wlmb.github.io/2025/09/07/PWC338/#task-1-highest-row
use v5.36;
use feature qw(try);
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 M1 M2...
    to find the maximum rowwise sum of the elements of the
    matrices Mi. The inputs are strings of the form
    "[[m00 m01...][m10 m11...]...]" which may be parsed
    by pdl as a matrix
    FIN
for(@ARGV){
    try{say "$_ -> ", pdl($_)->sumover->max}
    catch($e){say $e}
}
