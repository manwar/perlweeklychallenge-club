#!/usr/bin/perl
# 
# Task 1: "Chinese Zodiac
# 
# You are given a year $year.
# 
# Write a script to determine the Chinese Zodiac for the given year
# $year. Please check out https://en.wikipedia.org/wiki/Chinese_zodiac
# for more information about it.
# 
# The animal cycle: Rat, Ox, Tiger, Rabbit, Dragon, Snake, Horse, Goat,
# Monkey, Rooster, Dog, Pig.
# 
# The element cycle: Wood, Fire, Earth, Metal, Water.
# 
# Example 1:
# 
#     Input: 2017
#     Output: Fire Rooster
# 
# Example 2:
# 
#     Input: 1938
#     Output: Earth Tiger
# "
# 
# My notes: ok, so seems to be a 12 year cycle of animal names, intertwined
# with a 10 year cycle of 5 elements, two successive years having the same
# element each time.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: chinese-zodiac [--debug] YEAR\n"
	unless GetOptions( "debug" => \$debug )
	    && @ARGV==1;

my $year = shift;

my @animal = qw(Rat Ox Tiger Rabbit Dragon Snake Horse
		Goat Monkey Rooster Dog Pig);
my @element = qw(Wood Wood Fire Fire Earth Earth Metal Metal Water Water);

my $y = 1924;
my $e = 0;	# wood
my $a = 0;  	# rat

# the whole cycle lasts 60 years.. so find start of cycle before $year
for( ; $year < $y; $y -= 60 )
{
}
say "debug: year=$year, y=$y" if $debug;

for( ; $year > $y; $y++ )
{
	$a++;
	$a %= @animal;
	$e++;
	$e %= @element;
}

say "$element[$e] $animal[$a]";
