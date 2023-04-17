#!/usr/bin/env perl
# Perl weekly challenge 213
# Task 1:  Fun Sort
#
# See https://wlmb.github.io/2023/04/17/PWC213/#task-1-fun-sort
use v5.36;
use POSIX qw(floor);
use List::Util qw(all);

die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to fun-sort the integers N1 N2...
    FIN
die "Input should be non-negative integers" unless all {floor($_)==$_ && $_>=0} @ARGV;
say join " ", @ARGV, "->", sort {$a%2 <=> $b%2 || $a<=>$b} @ARGV;
