#!/usr/bin/env perl
# Perl weekly challenge 289
# Task 1:  Third Maximum
#
# See https://wlmb.github.io/2024/09/29/PWC289/#task-1-third-maximum
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to obtain the third maximum of the sequence of numbers N1 N2...
    FIN
my %count;
++$count{$_} for @ARGV;
my @sorted=sort {$b cmp $a} keys %count;
say "@ARGV -> ", $sorted[2]//$sorted[0];
