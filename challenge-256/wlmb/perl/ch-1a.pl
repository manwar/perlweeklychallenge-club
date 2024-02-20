#!/usr/bin/env perl
# Perl weekly challenge 256
# Task 1:  Maximum Pairs
#
# See https://wlmb.github.io/2024/02/12/PWC256/#task-1-maximum-pairs
use v5.36;
use List::Util qw(sum0);
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 [S2...]
    to pair Si with the reverse Sj and count the resulting pairs
    FIN
my %count;
++$count{$_} for (@ARGV);
my $result = (sum0 map {
    my $reverse=reverse $_;
    my $selfreverse=$_ eq $reverse;
    $count{$_}*(($count{$reverse}//0)-$selfreverse)
} keys %count)/2;
say "@ARGV -> $result";
