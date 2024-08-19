#!/usr/bin/env perl
# Perl weekly challenge 283
# Task 2:  Digit Count Value
#
# See https://wlmb.github.io/2024/08/19/PWC283/#task-2-digit-count-value
use v5.36;
my %count;
$count{$_}++ for @ARGV;
my $result="True";
(($count{$_}//0)==$ARGV[$_]) || ($result="False") for 0..@ARGV-1;
say "@ARGV -> $result"
