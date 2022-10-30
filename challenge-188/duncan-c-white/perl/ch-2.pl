#!/usr/bin/perl
# 
# Task 2: Total Zero
# 
# You are given two positive integers $x and $y.
# 
# Write a script to find out the number of operations needed to make both
# ZERO. Each operation is made up either of the following:
# 
# $x = $x - $y if $x >= $y
# 
# or
# 
# $y = $y - $x if $y >= $x (using the original value of $x)
# 
# Example 1
# 
# 	Input: $x = 5, $y = 4
# 	Output: 5
# 
# Example 2
# 
# 	Input: $x = 4, $y = 6
# 	Output: 3
# 
# Example 3
# 
# 	Input: $x = 2, $y = 5
# 	Output: 4
# 
# Example 4
# 
# 	Input: $x = 3, $y = 1
# 	Output: 3
# 
# Example 5
# 
# 	Input: $x = 7, $y = 4
# 	Output: 5
# 
# MY NOTES: Ok, sounds easy enough, especially with some debug mode code
# showing how x and y change, round by round.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: total-zero [--debug] x y\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;

my( $x, $y ) = @ARGV;

die "total-zero: x ($x) must be +ve\n" if $x<0;
die "total-zero: y ($y) must be +ve\n" if $y<0;

my $count = 0;
say "debug: count=$count, x=$x, y=$y" if $debug;
while( $x>0 && $y>0 )
{
	if( $x >= $y )
	{
		$x -= $y;
	} else
	{
		$y -= $x;
	}
	$count++;
	say "debug: count=$count, x=$x, y=$y" if $debug;
}
say $count;
