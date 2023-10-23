#!/usr/bin/env perl
# Perl weekly challenge 240
# Task 2:  Build Array
#
# See https://wlmb.github.io/2023/10/23/PWC240/#task-2-build-array
use v5.36;
use List::Util qw(min max);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 [N1...]
    to iterate indexing the array N0, N1...
    FIN
die "Elements should be >=0 and < #of elements" unless 0<=min @ARGV && max @ARGV<@ARGV;
say "@ARGV -> @ARGV[@ARGV]";
