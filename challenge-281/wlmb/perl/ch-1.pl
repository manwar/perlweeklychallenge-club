#!/usr/bin/env perl
# Perl weekly challenge 281
# Task 1:  Check Color
#
# See https://wlmb.github.io/2024/08/04/PWC281/#task-1-check-color
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage $0 P1 P2...
    to test whether position Pi in a chessboard corresponds to a white square,
    where Pi is of the form xy with x a letter in the range a-h and y a digit
    in the range 1-8.
    FIN
for(@ARGV){
    warn("Bad format: $_"), next unless /^([a-hA-H])([1-7])$/;
    my $x=ord(lc $1)-ord("a"); # convert to number 0-7
    my $y=$2-1;
    my $result=($x+$y)%2?"True":"False";
    say "$_ -> $result";
}
