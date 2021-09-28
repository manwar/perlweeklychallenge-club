#!/usr/bin/env perl
# Perl weekly challenge 130
# Task 1:  Odd number
#
# See https://wlmb.github.io/2021/09/15/PWC130/#task-1-odd-number
use warnings;
use v5.12;
my %repetitions_of;
map {++$repetitions_of{$_}} @ARGV;
my @output=grep {$repetitions_of{$_}%2} keys %repetitions_of;
say "Input: ", join " ", @ARGV;
say "Output: ", @output==1?$output[0]:"Wrong input";
