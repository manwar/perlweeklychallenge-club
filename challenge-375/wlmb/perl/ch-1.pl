#!/usr/bin/env perl
# Perl weekly challenge 375
# Task 1:  Single Common Word
#
# See https://wlmb.github.io/2026/05/26/PWC375/#task-1-single-common-word
use v5.36;
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 X0 Y0 X1 Y1...
    to find those space separated words that appear exactly once
    in strings Xn and Yn
    FIN
for my ($x,$y) (@ARGV){
    my(%count_x, %count_y);
    $count_x{$_}++ for split " ", $x;
    $count_y{$_}++ for split" ", $y;
    say"\"$x\", \"$y\" -> ",0+grep{($count_x{$_}//0) == ($count_y{$_}//0) == 1}
        keys %count_x;
}
