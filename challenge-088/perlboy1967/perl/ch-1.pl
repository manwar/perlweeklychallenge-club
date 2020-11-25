#!/usr/bin/perl

# Perl Weekly Challenge - 088
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-088/
#
# Task 1 - Array of Product
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use Data::Printer;

# Unbuffered STDOUT
$|++;

@ARGV = (5, 2, 1, 4, 3)
  unless scalar(@ARGV);

die "Please provide minimally three positive integer numbers"
  unless (scalar @ARGV > 2 and
          scalar grep { /^[1-9][0-9]*$/} @ARGV == scalar @ARGV);

my @N = @ARGV;

my $product = 1;
map { $product *= $_ } @N;

my @M = map { $product / $_ } @N;

p @M;
