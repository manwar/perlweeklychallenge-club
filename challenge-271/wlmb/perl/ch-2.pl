#!/usr/bin/env perl
# Perl weekly challenge 271
# Task 2:  Sort by 1 bits
#
# See https://wlmb.github.io/2024/05/28/PWC271/#task-2-sort-by-1-bits
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to sort the numbers N1, N2... according to the number of 1 bits
    and then according to value
    FIN
my @sorted = sort {ones($a) <=> ones($b) || $a<=>$b} @ARGV;
say "@ARGV -> @sorted";

sub ones($x){
    0+grep{$_}split "", sprintf "%b",$x;
}
