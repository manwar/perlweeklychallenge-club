#!/usr/bin/perl
# 
# Task 1: "Disjoint Sets
# 
# You are given two sets with unique integers.
# 
# Write a script to figure out if they are disjoint.
# 
# The two sets are disjoint if they don't have any common members.
# 
# Example
# 
#   Input: @S1 = (1, 2, 5, 3, 4)
#          @S2 = (4, 6, 7, 8, 9)
#   Output: 0 as the given two sets have common member 4.
# 
#   Input: @S1 = (1, 3, 5, 7, 9)
#          @S2 = (0, 2, 4, 6, 8)
#   Output: 1 as the given two sets do not have common member.
# "
# 
# My notes: very easy:  Intersection is not empty.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

my $debug=0;
die "Usage: disjoint-sets [-d|--debug] SET1 SET2\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==2;
my %s1 = map { $_ => 1 } split(/,/,$ARGV[0]);
my @common = grep { $s1{$_} } split(/,/,$ARGV[1]);
say join(',',@common) if $debug && @common;
say( (@common==0)?1:0);
