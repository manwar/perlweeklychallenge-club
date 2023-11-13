#!/usr/bin/env perl
# Perl weekly challenge 242
# Task 2:  Flip Matrix
#
# See https://wlmb.github.io/2023/11/06/PWC242/#task-2-flip-matrix
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 M0 [M1...]
    to reverse the rows and invert the elements of the matrices M0 M1...
    provided as strings like "[[m00 m01...],[m10 m11...]...]"
    FIN
for(@ARGV){
    my $x=pdl($_);
    say "Input${x}Output", !$x->slice([-1,0]);
}
