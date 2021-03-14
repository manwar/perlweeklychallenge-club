#!/usr/bin/perl

# Perl Weekly Challenge - 103
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-103/#TASK1
#
# Task 1 - Chinese zodiac
#
# Author: Niels 'PerlBoy' van Dijke
#
# Note: Assuming to print the Zodiac sign for Jan 1st

use v5.16;
use strict;
use warnings;

my @animalCycle = qw(
  Rat Ox Tiger Rabbit Dragon Snake
  Horse Goat Monkey Rooster Dog Pig
);
my @elementCycle = qw(
  Wood Fire Earth Metal Water
);

@ARGV = (2021)
  unless (scalar @ARGV);

my $YEAR = shift;

printf "Input: %d\n", $YEAR;
printf "Output: %s %s\n", 
       $elementCycle[int(($YEAR+6)/2)%5], 
       $animalCycle[($YEAR+8)%12];
       
