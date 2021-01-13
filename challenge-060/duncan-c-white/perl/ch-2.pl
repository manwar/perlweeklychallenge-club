#!/usr/bin/perl
# 
# Task 2: "Find Numbers
#
# Write a script that accepts list of positive numbers (@L) and two positive
# numbers $X and $Y.
# 
# The script should print all possible numbers made by concatenating the
# numbers from @L, whose length is exactly $X but value is less than $Y.
# Example
# 
# Input:
# 
# @L = (0, 1, 2, 5);
# $X = 2;
# $Y = 21;
# 
# Output:
# 
# 10, 11, 12, 15, 20
# "
# 
# My notes: sounds quite straightforward. I note that "01" is not a solution,
# so leading zeroes aren't allowed.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;

#
# find_recursive( $prefix, $x, $y, $lref, $resultref );
#	Find all possible numbers made by concatenating the numbers from @$lref,
#	whose length is exactly $X but value is less than $Y, given that
#	the prefix (numeric string) is $prefix.  Add answers to @$resultref.
#
fun find_recursive( $prefix, $x, $y, $lref, $resultref )
{
	foreach my $el (@$lref)
	{
		my $newp = $prefix.$el;
		my $newlen = length($newp);
		next if $newp >= $y || $newlen > $x;

		push @$resultref, $newp if $newp < $y && $newlen==$x;

		# try with that element appended to the prefix
		find_recursive( $newp, $x, $y, $lref, $resultref );
	}
}



#
# my @result = findall( $x, $y, @l );
#	Find all possible numbers made by concatenating the numbers from @l,
#	whose length is exactly $X but value is less than $Y.
#
fun findall( $x, $y, @l )
{
	my @result;
	foreach my $el (@l)
	{
		next if $el =~ /^0/;
		next if $el >= $y || length($el) > $x;
		push @result, $el if $el < $y && length($el)==$x;

		# try that element as the prefix of the number..
		find_recursive( $el, $x, $y, \@l, \@result );
	}
	return @result;
}



die "Usage: find-numbers X Y Numlist\n" if @ARGV < 3;
my( $x, $y, @l ) = @ARGV;

my @result = findall( $x, $y, @l );
say join(', ',@result);
