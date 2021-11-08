#!/usr/bin/perl
# 
# Task 2: "Tug of War
# 
# You are given a set of $n integers (n1, n2, n3, ...).
# 
# Write a script to divide the set in two subsets of n/2 sizes each so
# that the difference of the sum of two subsets is the least. If $n is
# even then each subset must be of size $n/2 each. In case $n is odd then
# one subset must be ($n-1)/2 and other must be ($n+1)/2.
# 
# Example
# 
#   Input:        Set = (10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
#   Output:  Subset 1 = (30, 40, 60, 70, 80)
#            Subset 2 = (10, 20, 50, 90, 100)
# 
#   Input:        Set = (10, -15, 20, 30, -25, 0, 5, 40, -5)
#            Subset 1 = (30, 0, 5, -5)
#            Subset 2 = (10, -15, 20, -25, 40)
# "
# 
# My notes: sounds like a "generate and test" problem.  Easy to do
#	  inefficiently, challenging to try to make efficient.
#	  Let's start by counting from 0 to 2^n-1 and using the bits
#	  to select which subset to put each value into.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use List::Util qw(sum);
use Data::Dumper;

die "Usage: tug-of-war N1 N2...\n" unless @ARGV>1;
my @n = @ARGV;

my $two2n = 2**scalar(@n);


#
# partition( $partno, $ss1, $ss2, @n );
#	Partition @n into @$ss1 and @$ss2 based on the partition no $partno.
#
fun partition( $partno, $ss1, $ss2, @n )
{
	@$ss1 = @$ss2 = ();
	for( my $i=0; $i<@n; $i++ )
	{
		my $bit = ($partno % 2);
		$partno /= 2;
		my $aref = $bit ? $ss1 : $ss2;
		push @$aref, $n[$i];
	}
}


my $debug = 0;

my $minsumdiff = sum(@n);
my @bests1 = @n;
my @bests2 = ();

my $halfn = int(@n / 2);

for( my $i=0; $i<$two2n; $i++ )
{
	my( @s1, @s2 );
	partition( $i, \@s1, \@s2, @n );
	next unless @s1 == $halfn;

	my $sum1 = sum(@s1);
	my $sum2 = sum(@s2);
	my $diff = abs($sum1-$sum2);

	say "partition $i has s1=". join(',',@s1). ", s2==". join(',',@s2). ", diff=$diff" if $debug;

	if( $diff < $minsumdiff )
	{
		$minsumdiff = $diff;
		@bests1 = @s1;
		@bests2 = @s2;
	}
}

say "Subset 1   = ". join(',',@bests1);
say "Subset 2   = ". join(',',@bests2);
say "Difference = $minsumdiff";
