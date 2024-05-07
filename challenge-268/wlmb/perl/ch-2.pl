#!/usr/bin/env perl
# Perl weekly challenge 268
# Task 2:  Number Game
#
# See https://wlmb.github.io/2024/05/06/PWC268/#task-2-number-game
use v5.36;
use experimental qw(for_list);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 N1 N2... N2m
    to print array even sized array N1..N2m in zig-zag order
    (decreasing pairs of increasing value)
    FIN
my @result;
for my($x, $y)(sort {$a<=>$b} @ARGV){
    push @result, sort{$b<=>$a}($x,$y)
}
say "@ARGV -> @result";
