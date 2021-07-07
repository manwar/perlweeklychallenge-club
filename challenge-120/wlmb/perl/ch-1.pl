#!/usr/bin/env perl
# Perl weekly challenge 120
# Task 1: Swap odd/even bits
#
# See https://wlmb.github.io/2021/07/07/PWC220/#task-2-swap-oddeven-bits
use strict;
use warnings;
use v5.12;
use List::Util qw(all);
my $odd=170; # 10101010
my $even=85; # 01010101

say "Input: $_, Output: ",
     0<=$_<=255?((($_&$odd)>>1) |(($_&$even)<<1)):"Invalid"
     for @ARGV;
