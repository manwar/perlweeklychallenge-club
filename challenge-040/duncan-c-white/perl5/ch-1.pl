#!/usr/bin/perl
#
# Task 1: "Show multiple arrays content:
#
# You are given two or more arrays. Write a script to display values of
# each list at a given index.
# 
# For example:
# Array 1: [ I L O V E Y O U ]
# Array 2: [ 2 4 0 3 2 0 1 9 ]
# Array 3: [ ! ? £ $ % ^ & * ]
# 
# We expect the following output:
# 
# I 2 !
# L 4 ?
# O 0 £
# V 3 $
# E 2 %
# Y 0 ^
# O 1 &
# U 9 *
# "
# 
# My notes: trivial.  Each array on command line as a word, i.e. array elements
# are single characters?  Allow any number of arrays (arguments) >= 2.
# Also handle the case where the arrays are not necessarily of the same length,
# by displaying '?' for any element off the end of an array.
# 

use v5.10;	# to get "say"
use strict;
use warnings;
#use Data::Dumper;

die "Usage: ch-1.pl ARRAY1 ARRAY2 [ARRAYn..]\n" if @ARGV<2;

my $n = @ARGV;
my $len = length($ARGV[0]);

foreach my $i (1..$#ARGV)
{
	my $al = length($ARGV[$i]);
	# find longest
	$len = $al if $al > $len;
}

foreach my $i (0..$len-1)
{
	my @el;
	foreach my $arg (@ARGV)
	{
		my $oneel = length($arg)>$i ? substr($arg,$i,1) : '?';
		push @el, $oneel;
	}
	say join( " ", @el );
}
