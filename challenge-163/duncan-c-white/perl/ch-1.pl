#!/usr/bin/perl
# 
# TASK #1 - Sum Bitwise Operator
# 
# You are given a list of positive numbers, @n.
# 
# Write script to calculate the sum of bitwise & operator for all unique pairs.
# 
# Example 1
# 
# 	Input: @n = (1, 2, 3)
# 	Output: 3
# 
# 	Since (1 & 2) + (2 & 3) + (1 & 3) => 0 + 2 + 1 =>  3.
# 
# Example 2
# 
# 	Input: @n = (2, 3, 4)
# 	Output: 2
# 
# 	Since (2 & 3) + (2 & 4) + (3 & 4) => 2 + 0 + 0 =>  2.
# 
# MY NOTES: ok.  Pretty easy.  Identify all pairs, xor each, sum results.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl into C,
# look in the C directory for that.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(sum0);

my $debug=0;
die "Usage: sum-bitwise-pairs [--debug] list of numbers\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>1;
my @v = @ARGV;


#
# my @pairs = all_pairs( @x );
#	Form a list of all pairs of elements in @x in the obvious way
#
sub all_pairs (@)
{
	my( @x ) = @_;
	my $lastpos = $#x;
	my @pairs;
	foreach my $i (0..$lastpos-1)
	{
		foreach my $j ($i+1..$lastpos)
		{
			my $a = $x[$i];
			my $b = $x[$j];
			say "debug: i=$i, j=$j, a=$a, b=$b" if $debug;
			push @pairs, [$a,$b];
		}
	}
	return @pairs;
}


my @pairs = all_pairs( @v );
#die Dumper(\@pairs);

# now calculate sum( bitwise_and(a,b) ) for all (a,b) pairs
my $sum = sum0( map { my($a,$b)=@$_; $a & $b } @pairs );

say $sum;

# Note: we could have written this as:
#
# say sum0( map { my($a,$b)=@$_; $a & $b } all_pairs(@v) );
