#!/usr/bin/perl
#
# Task 2: "Rotate String
#
# Given a word made up of an arbitrary number of x and y characters, that
# word can be rotated as follows: For the ith rotation (starting at i =
# 1), i % length(word) characters are moved from the front of the string to
# the end. Thus, for the string xyxx, the initial (i = 1) % 4 = 1 character
# (x) is moved to the end, forming yxxx. On the second rotation, (i = 2) %
# 4 = 2 characters (yx) are moved to the end, forming xxyx, and so on. See
# below for a complete example.
# 
# Your task is to write a function that takes a string of xs and ys and
# returns the minimum non-zero number of rotations required to obtain
# the original string. You may show the individual rotations if you wish,
# but that is not required.
# 
# Example
# 
# Input: $word = 'xyxx';
# 
# Rotation 1: you get yxxx by moving x to the end.
# Rotation 2: you get xxyx by moving yx to the end.
# Rotation 3: you get xxxy by moving xxy to the end.
# Rotation 4: you get xxxy by moving nothing as 4 % length(xyxx) == 0.
# Rotation 5: you get xxyx by moving x to the end.
# Rotation 6: you get yxxx by moving xx to the end.
# Rotation 7: you get xyxx by moving yxx to the end which is the original.
# 
# Output: 7
# "
# 
# My notes: sounds like fun.  Nice question.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;

my $verbose = 0;
my $result = GetOptions( "verbose" => \$verbose );
die "Usage: rotate-string [-v|--verbose] xystring\n" unless
	$result && @ARGV==1;
my $xy = shift;

#
# my $n = rotate( $xy );
#	Rotate the $xy string (a sequence of xs and ys)
#	repeatedly as described in the top comment,
#	and return the number of rotations needed before
#	we get back to the original $xy string.
#
fun rotate( $xy )
{
	my $len = length($xy);
	my $curr = $xy;
	my $n;
	for( $n=0; ; $n++ )
	{
		my $n4 = $n % 4;
		next if $n4==0;
		my $new = substr($curr,$n4,$len-$n4).substr($curr,0,$n4);
		say "rotation $n: $new" if $verbose;
		$curr = $new;
		last if $curr eq $xy;
	}
	return $n;
}


my $n = rotate( $xy );
say "$n rotations needed";
