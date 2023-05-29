#!/usr/bin/env perl
# Perl weekly challenge 219
# Task 1:  Sorted Squares
#
# See https://wlmb.github.io/2023/05/29/PWC219/#task-1-sorted-squares
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 -- N1 [N2...]
    to square and sort the numbers N1 N2...
    The -- is to allow negative numbers as arguments without
    confusing them with options.
    FIN
say "@ARGV ->", join " ", sort {$a<=>$b} map {$_**2} @ARGV;
