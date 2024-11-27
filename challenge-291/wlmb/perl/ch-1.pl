#!/usr/bin/env perl
# Perl weekly challenge 291
# Task 1:  Middle Index
#
# See https://wlmb.github.io/2024/10/14/PWC291/#task-1-middle-index
use v5.36;
use List::Util qw(sum0);
say <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to find the middle index of the array of numbers N0, N1...
    FIN
my $left=0;
my $right=sum0(@ARGV);
my $current=0;
while(1){
    $current = -1, last if $current==@ARGV;
    $right -= $ARGV[$current];
    last if $right == $left;
    $left += $ARGV[$current++];
}
say "@ARGV -> $current";
