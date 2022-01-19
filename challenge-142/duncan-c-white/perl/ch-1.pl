#!/usr/bin/perl
# 
# TASK #1 - Divisor Last Digit
# 
# You are given positive integers, $m and $n.
# 
# Write a script to find total count of divisors of $m having last digit $n.
# 
# Example 1:
# 
# 	Input: $m = 24, $n = 2
# 	Output: 2
# 
# 	The divisors of 24 are 1, 2, 3, 4, 6, 8 and 12.
# 	There are only 2 divisors having last digit 2 are 2 and 12.
# 
# Example 2:
# 
# 	Input: $m = 30, $n = 5
# 	Output: 2
# 
# 	The divisors of 30 are 1, 2, 3, 5, 6, 10 and 15.
# 	There are only 2 divisors having last digit 5 are 5 and 15.
# 
# MY NOTES: Very easy.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

#
# my @div = divisors( $n );
#	Find and return all the divisors of $n, including 1.
#
sub divisors
{
	my( $n ) = @_;
	my @d = (1);
	my $halfn = int($n/2);
	for( my $i=2; $i<=$halfn; $i++ )
	{
		push @d, $i if $n%$i==0;
	}
	push @d, $n;
	return @d;
}


my $debug=0;
die "Usage: divisor-last-digit [--debug] M N\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==2;
my( $m, $n ) = @ARGV;

my @div = grep { $_ % 10 == $n } divisors( $m );
my $d = @div;

say "$m has $d divisors with last digit $n";
say "  they are ", join(', ',@div) if $debug;
