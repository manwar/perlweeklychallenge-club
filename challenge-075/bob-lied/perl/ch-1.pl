#!/usr/bin/perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu syntax=perl:
#
# Copyright (c) 2020 Bob Lied
# The copyright notice above does not evidence any actual
# or intended publication of such source code.

#===============================================================================
# ch-1.pl
#
# Description: 
# Perl Weekly Challenge 075 Task #1 > Coins Sum
#===============================================================================
# You are given a set of coins @C, assuming you have infinite amount of each coin in the set.
# Write a script to find how many ways you make sum $S using the coins from the set @C.
# 
# Example:
# Input:
#     @C = (1, 2, 4)
#     $S = 6
# 
# Output: 6
# There are 6 possible ways to make sum 6.
# a) (1, 1, 1, 1, 1, 1)
# b) (1, 1, 1, 1, 2)
# c) (1, 1, 2, 2)
# d) (1, 1, 4)
# e) (2, 2, 2)
# f) (2, 4)

use strict;
use warnings;
use feature qw(say);

use Data::Dumper;

use lib "lib";
use CoinSum qw(coinSum);

sub Usage { "Usage: $0 SUM coin1 [coin2..coinN]" };

my $S = shift;
my @C = @ARGV;

die Usage() unless $S;
die Usage() unless @C;


my $result = coinSum($S, @C);

say "[ @$_ ]" foreach @$result;
