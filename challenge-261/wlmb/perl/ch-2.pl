#!/usr/bin/env perl
# Perl weekly challenge 261
# Task 2:  Multiply by Two
#
# See https://wlmb.github.io/2024/03/18/PWC261/#task-2-multiply-by-two
use v5.36;
use List::Util qw(first);
die <<~"FIN" unless @ARGV >= 2;
    Usage: $0 S N1 [N2...]
    to find the smallest number S*2^n that is not in the list N1 N2...
    FIN
my ($start, @ints)=@ARGV;
print "Start=$start, ints=@ints -> ";
$start *= 2 while defined first {$_==$start} @ints;
say $start;
