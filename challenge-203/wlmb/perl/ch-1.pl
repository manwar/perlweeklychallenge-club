#!/usr/bin/env perl
# Perl weekly challenge 203
# Task 1:  Special Quadruplets
#
# See https://wlmb.github.io/2023/02/06/PWC203/#task-1-special-quadruplets
use v5.36;
use Algorithm::Combinatorics qw(combinations);
say join " ", @ARGV, "->", 0+grep {$_->[3]==$_->[0]+$_->[1]+$_->[2]}  combinations(\@ARGV,4);
