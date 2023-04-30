#!/usr/bin/perl
# 
# Task 1: Rank Score
# 
# You are given a list of scores (>=1).
# 
# Write a script to rank each score in descending order. First three will
# get medals i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get
# the ranking number.
# 
# Use the standard model of giving equal scores equal rank, then advancing
# that number of ranks.
# 
# Example 1
# 
#   Input: @scores = (1,2,4,3,5)
#   Output: (5,4,S,B,G)
# 
#   Score 1 is the 5th rank.
#   Score 2 is the 4th rank.
#   Score 4 is the 2nd rank i.e. Silver (S).
#   Score 3 is the 3rd rank i.e. Bronze (B).
#   Score 5 is the 1st rank i.e. Gold (G).
# 
# Example 2
# 
#   Input: @scores = (8,5,6,7,4)
#   Output: (G,4,B,S,5)
# 
#   Score 8 is the 1st rank i.e. Gold (G).
#   Score 4 is the 4th rank.
#   Score 6 is the 3rd rank i.e. Bronze (B).
#   Score 7 is the 2nd rank i.e. Silver (S).
#   Score 4 is the 5th rank.
# 
# Example 3
# 
#   Input: @list = (3,5,4,2)
#   Output: (B,G,S,4)
# 
# Example 4
# 
#   Input: @scores = (2,5,2,1,7,5,1)
#   Output: (4,S,4,6,G,S,6)
# 
# MY NOTES: sounds pretty easy, although scores (high is best) and ranks (low
# is best) are a little confusing.  Even worse is joint ranks for equal scores.
# Start from the end: Gold is a label for rank 1, Single is a label for rank 2,
# Bronze is a label for rank 3.  So work out the ranks (including the nasty
# joint ranks thing) and then apply the G/S/B stuff at the end.
# 
# GUEST LANGUAGE: As a bonus, I've had a go at translating ch-1.pl into C,
# look in the C/ directory for that.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(any);

my $debug=0;
die "Usage: rank-score [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @list = split( /,/, join(',',@ARGV) );

say "debug: list: ", join(',',@list) if $debug;

# distinct values in sorted order
my %set = map { $_ => 1 } @list;
my @distinctsortval = sort { $b <=> $a } keys %set;

# allocate ranks, coping with joint ranks..
my $rank = 1;
my @result;
foreach my $val (@distinctsortval)
{
	my @pos = grep { $list[$_] == $val } 0..$#list;
	$result[$_] = $rank for @pos;
	$rank += @pos;
}

# change ranks 1..3 -> G,S,B
foreach my $v (@result)
{
	$v = 'G' if $v eq 1;
	$v = 'S' if $v eq 2;
	$v = 'B' if $v eq 3;
}

say join(',', @result);
