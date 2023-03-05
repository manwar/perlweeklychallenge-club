#!/usr/bin/perl
# 
# Task 1: Third Highest
# 
# You are given an array of integers.
# 
# Write a script to find out the Third Highest if found otherwise return
# the maximum.
# 
# Example 1
# 
#   Input: @array = (5,3,4)
#   Output: 3
# 
#   First highest is 5.
#   Second highest is 4.
#   Third highest is 3.
# 
# Example 2
# 
#   Input: @array = (5,6)
#   Output: 6
# 
#   First highest is 6.
#   Second highest is 5.
#   Third highest is missing, so maximum is returned.
# 
# Example 3
# 
#   Input: @array = (5,4,4,3)
#   Output: 3
# 
#   First highest is 5. Second highest is 4. Third highest is 3.
# 
# MY NOTES: seems very easy.  sort, take 3rd biggest distinct element
# (or biggest element if less than 3)
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for the translation)
#

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: third-highest [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @list = split( /,/, join(',',@ARGV) );

@list = sort { $b <=> $a } @list;

say "sorted: ", join(',',@list) if $debug;

# remove dups
my %seen;
@list = grep { ! $seen{$_}++ } @list;

say "nodups: ", join(',',@list) if $debug;

my $third = ( @list > 2 ) ? $list[2] : $list[0];
say $third;
