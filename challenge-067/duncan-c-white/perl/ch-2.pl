#!/usr/bin/perl
#
# Task 2: "Letter Phone
#
# You are given a digit string $S. Write a script to print all possible
# letter combinations that the given digit string could represent.
# 
# (1 represents _ or @,
# 2 A,B or C,
# 3 D,E or F,
# 4 G, H or I,
# 5 J, K or L,
# 6 M, M or O,
# 7 P, Q, R or S,
# 8 T, U or V,
# 9 W, X, Y or Z
# letters from a phone panel)
# 
# Example:
# 
#   Input: $S = '35'
# 
#   Output: ["dj", "dk", "dl", "ej", "ek", "el", "fj", "fk", "fl"].
# 
# My notes: sounds pretty easy.  Lookup the set of possibilities for each
# letter, then cross-product them.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

die "Usage: letter-phone numstring\n" unless @ARGV==1;
my $numstring = shift;

my %data = (1 => '_@',
	2 => 'abc',
	3 => 'def',
	4 => 'ghi',
	5 => 'jkl',
	6 => 'mmo',
	7 => 'pqrs',
	8 => 'tuv',
	9 => 'wxyz',
	);

#
# my @out = cross( @str );
#	Given an array of strings, where each string represents
#	alternative letters, form an array of all cross-products
#	of all those letters.
#	eg. cross( 'DEF', 'GHI' ) = ( 'DG', DH', 'DI', 'EG'..)
#
fun cross( @str )
{
	my $first = shift @str;
	my @x = split(//,$first);
	foreach my $next (@str)
	{
		@x = cross_one( $next, @x );
	}
	return @x;
}


#
# my @out = cross_one( $next, @x );
#	Given a string $next (representing alternative letters) and an
#	array of strings @x, form a new array @out which contains every
#	element of @x with every letter in $next appended.
#	eg cross_one( 'DEF', 'X', 'Y' ) gives 'XD', 'XE', 'XF', 'YD'..
#
fun cross_one( $next, @x )
{
	my @out;
	my @letters = split(//,$next);
	foreach my $word (@x)
	{
		foreach my $letter (@letters)
		{
			push @out, $word.$letter;
		}
	}
	return @out;
}


my @str;
foreach my $digit (split(//,$numstring))
{
	die "bad digit $digit in $numstring" unless defined $data{$digit};
	push @str, $data{$digit};
}
#say Dumper \@str;

my @out = cross( @str );
say "[", join(',', map { "'$_'" } @out), "]";
