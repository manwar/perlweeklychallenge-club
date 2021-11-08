#!/usr/bin/env perl
# Perl weekly challenge 116
# Task 2: Sum of squares
#
# See https://wlmb.github.io/2021/06/11/PWC116/#task-2-sum-of-squares
use strict;
use warnings;
use List::Util qw(sum0);
use POSIX qw(round);
use v5.12;

foreach(@ARGV){
    my $x=sqrt(sum0 map {$_**2} split '',$_);
    say "Input: $_\nOutput: ", $x==round($x)?1:0;
}
