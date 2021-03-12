#!/usr/bin/perl

# Challenge 103
#
# TASK #1 › Chinese Zodiac
# Submitted by: Mohammad S Anwar
# You are given a year $year.
#
# Write a script to determine the Chinese Zodiac for the given year $year.
# Please check out wikipage for more information about it.
#
# The animal cycle: Rat, Ox, Tiger, Rabbit, Dragon, Snake, Horse, Goat, Monkey,
# Rooster, Dog, Pig.
# The element cycle: Wood, Fire, Earth, Metal, Water.
#
# Example 1:
#     Input: 2017
#     Output: Fire Rooster
# Example 2:
#     Input: 1938
#     Output: Earth Tiger

use strict;
use warnings;
use 5.030;

my @animals = qw(Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig);
my @elements = qw(Wood Wood Fire Fire Earth Earth Metal Metal Water Water);

my($year) = @ARGV;
defined $year or $year = 1900+ (localtime(time))[5];
my $num_years = $year-1924;
my $element = $num_years % scalar(@elements);
my $animal = $num_years % scalar(@animals);

say $elements[$element]," ",$animals[$animal];
