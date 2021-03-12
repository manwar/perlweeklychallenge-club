#!/usr/bin/perl
# The Weekly Challenge #103
# Task 1 Chinese Zodiac
# Usage: ch-1.pl YEAR
use strict;
use warnings;

my $yr = $ARGV[0];

my @animal = qw/Rat Ox Tiger Rabbit Dragon Snake 
            Horse Goat Monkey Rooster Dog Pig/;

my @element = qw/Wood Fire Earth Metal Water/;

print "$element[ ( ($yr-4) % 10) / 2 ] $animal[$yr % 12 - 4]\n";
