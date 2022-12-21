#!/usr/bin/perl
# 
# Task 1: Special Integers
# 
# You are given a positive integer, $n > 0.
# 
# Write a script to print the count of all special integers between 1 and $n:
# An integer is special when all of its digits are unique.
# 
# Example 1:
# 
# Input: $n = 15
# Output: 14 as except 11 all other integers between 1 and 15 are spcial.
# 
# Example 2:
# 
# Input: $n = 35
# Output: 32 as except 11, 22, 33 all others are special.
# 
# MY NOTES: very easy; use a freq hash
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
die "Usage: special-integers [--debug] N>0\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

=pod

=head2 my $isspecial = special( $x );

Return 1 iff $x is special; 0 otherwise.

=cut
sub special
{
	my( $x ) = @_;
	my %freq;
	foreach my $digit (split(//, $x))
	{
		return 0 if ++$freq{$digit}>1;
	}
	return 1;
}



my $n = shift;

die "special-integers: n $n should be > 0\n" if $n<0;

my $nspec = 0;
foreach my $i (1..$n)
{
	if( special($i) )
	{
		$nspec++;
	} elsif( $debug )
	{
		say "debug: $i is not special";
	}
}
say $nspec;
