#!/usr/bin/env perl
# Perl weekly challenge 248
# Task 1:  Shortest Distance
#
# See https://wlmb.github.io/2023/12/17/PWC248/#task-1-shortest-distance
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV==2;
    Usage: $0 string letter
    to obtain the shortest distances.
    FIN
my @letters=split "", $ARGV[0];
my $i=pdl(grep {$letters[$_] eq $ARGV[1]} 0..@letters-1);
my $j=sequence(0+@letters);
say "@ARGV; $ARGV[1] -> ", ($i->dummy(1)-$j->dummy(0))->abs->minover;
