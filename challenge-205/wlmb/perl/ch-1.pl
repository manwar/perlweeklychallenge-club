#!/usr/bin/env perl
# Perl weekly challenge 205
# Task 1:  Third Highest
#
# See https://wlmb.github.io/2023/02/20/PWC205/#task-1-third-highest
use v5.36;
use List::Util qw(uniqint);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find the third highest number from the list N1 N2...
    FIN
my @list=(sort {$b<=>$a} uniqint @ARGV); # filter out repetitions and sort descending
push @list, ($list[0]) x 2; # Add two copies of the maximum at the end of the list
say join " ", @ARGV, "->", $list[2];
