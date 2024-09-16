#!/usr/bin/env perl
# Perl weekly challenge 283
# Task 1:  Unique Number
#
# See https://wlmb.github.io/2024/08/19/PWC283/#task-1-unique-number
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to find which of the numbers N1 N2... appears only once.
    FIN
my %count;
$count{$_}++ for @ARGV;
my @unique;
$count{$_}==1 && push @unique, $_ for keys %count;
say "@ARGV -> @unique";
