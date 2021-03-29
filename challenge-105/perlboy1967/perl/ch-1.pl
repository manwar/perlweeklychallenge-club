#!/usr/bin/perl

# Perl Weekly Challenge - 105
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-105/#TASK1
#
# Task 1 - Nth Root
#
# Author: Niels 'PerlBoy' van Dijke
#
# Nth root can be written as:
#
#        n/--     (1/n)
#   x = \/ K   = K

use v5.16;
use strict;
use warnings;

@ARGV = (5, 248832)
  unless scalar(@ARGV) == 2 or grep !/^\d+$/, @ARGV;

my ($n, $k) = @ARGV;

printf "Input: \$n = %d, \$k = %d\n", $n, $k;
printf "Output: %s\n", $k**(1/$n);
