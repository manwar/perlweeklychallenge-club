#!/usr/bin/env perl
# Perl weekly challenge 195
# Task 2:  Most Frequent Even
#
# See https://wlmb.github.io/2022/12/12/PWC195/#task-2-most-frequent-even
use v5.36;
my %count;
$count{$_}++ for grep {!($_&1)} @ARGV; # Filter evens and count them
my @sorted=sort {$count{$b} <=> $count{$a} || $a<=>$b} keys %count;
say join " ", @ARGV, " -> ", @sorted?shift @sorted:-1
