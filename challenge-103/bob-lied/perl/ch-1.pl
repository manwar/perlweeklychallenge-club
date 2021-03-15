#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 103, TASK #1 › Chinese Zodiac
#
# You are given a year $year.
# Write a script to determine the Chinese Zodiac for the given year $year.
# Please check out wikipage for more information about it.
#
# The animal cycle: Rat, Ox, Tiger, Rabbit, Dragon, Snake, Horse, Goat, Monkey,
# Rooster, Dog, Pig.
# The element cycle: Wood, Fire, Earth, Metal, Water.
#
# Example 1: Input: 2017    Output: Fire Rooster
# Example 2: Input: 1938    Output: Earth Tiger
#=============================================================================

use strict;
use warnings;
use 5.020;

use experimental qw/signatures/;

my @AnimalCycle = qw( Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig );
my @ElementCycle = qw( Wood Wood Fire Fire Earth Earth Metal Metal Water Water );

my $BaseYear = 1924;

my $year = shift;
die "Usage: $0 YEAR\n" unless $year;

my $relativeYear = $year - $BaseYear;

my  $animal = $relativeYear % @AnimalCycle;
my $element = $relativeYear % @ElementCycle;

say "$ElementCycle[$element] $AnimalCycle[$animal]";
