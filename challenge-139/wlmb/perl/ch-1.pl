#!/usr/bin/env perl
# Perl weekly challenge 139
# Task 1: JortSort
#
# See https://wlmb.github.io/2021/11/16/PWC139/#task-1-jortsort
use v5.12;
use warnings;
use List::Util qw(none);
say "Input: (", (join " ",@ARGV), ")";
my $x; # previous element
my $y=shift @ARGV; # current element
say "Output: ", (none {($x,$y)=($y,$_); $x>$y}@ARGV)?1:0;
