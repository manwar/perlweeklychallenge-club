#!/usr/bin/env perl
# Perl weekly challenge 260
# Task 1:  Unique Occurrences
#
# See https://wlmb.github.io/2024/03/10/PWC260/#task-1-unique-occurrences
use v5.36;
use List::Util qw(uniq);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to test if the number of ocurrences of each number is unique.
    FIN
my %counts;
++$counts{$_} for @ARGV;
my @counts=values %counts;
my $result=@counts==(uniq @counts)||0;
say "@ARGV => $result";
