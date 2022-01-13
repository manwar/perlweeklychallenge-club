#!/usr/bin/perl
# 
# TASK #1 - Dot Product
#
# You are given 2 arrays of same size, @a and @b.
# 
# Write a script to implement Dot Product.
# 
# Example:
# 
# 	@a = (1, 2, 3);
# 	@b = (4, 5, 6);
# 
# 	$dot_product = (1 * 4) + (2 * 5) + (3 * 6) => 4 + 10 + 18 => 32
# 
# MY NOTES: Very easy.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: dot-product [--debug] A1,A2.. B1,B2..\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==2;

#
# my $dp = dotproduct( $a, $b );
#	Produce and return the dot product of arrays @$a and @$b
#
sub dotproduct ($$)
{
	my( $a, $b ) = @_;
	my $na = @$a;
	my $nb = @$b;

	die "dot-product: A and B arrays must be same size (A has $na, B has $nb)\n"
		unless $na==$nb;
	
	my $result = 0;
	foreach my $i (0..$na-1)
	{
		$result += $a->[$i] * $b->[$i];
	}
	return $result;
}


my @a = split( /,/, shift );
my @b = split( /,/, shift );


my $dp = dotproduct( \@a, \@b );
say $dp;
