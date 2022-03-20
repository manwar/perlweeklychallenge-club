#!/usr/bin/perl
# 
# TASK #2 - Weird Number
# 
# You are given number, $n > 0.
# 
# Write a script to find out if the given number is a Weird Number.
# 
# According to Wikipedia, it is defined as:
# 
# The sum of the proper divisors (divisors including 1 but not itself) of
# the number is greater than the number, but no subset of those divisors
# sums to the number itself.
# 
# Example 1:
# 
# 	Input: $n = 12
# 	Output: 0
# 
# Since the proper divisors of 12 are 1, 2, 3, 4, and 6, which sum to 16;
# but 2 + 4 + 6 = 12.
# 
# Example 2:
# 
# 	Input: $n = 70
# 	Output: 1
# 
# As the proper divisors of 70 are 1, 2, 5, 7, 10, 14, and 35; these sum
# to 74, but no subset of these sums to 70.
# 
# MY NOTES: ok.  Handle "sum of subsets of these items" by noting that
# each item may be present or absent, so have a counting loop from 0..
# 2**(nitems)-1 and compute the sum of just those items selected by the
# binary bits of the count that are 1.
#
# Bonus: I added a "tabulate" facility (eg. run with --tabulate 5 to
# see the first 5 Weird numbers).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;
use List::Util qw(sum0);

my $debug=0;
my $tabulate=0;
die "Usage: is-weird [--debug] [--tabulate] N\n" unless
	GetOptions( "debug" => \$debug, "tabulate" => \$tabulate ) && @ARGV==1;


#
# my @divs = divisors_inc_1( $n );
#	Return the array of perfect divisors (including 1). 
#
fun divisors_inc_1( $n )
{
	my @result;
	my $limit = $n/2;
	for( my $i=1; $i<=$limit; $i++ )
	{
		push @result, $i if $n%$i==0;
	}
	return @result;
}


#
# my $isweird = weird( $n );
#	Return 1 iff $n is weird; 0 otherwise
#
fun weird( $n )
{
	my @divs = divisors_inc_1( $n );
	#say "w($n): divs: ", join(',',@divs);

	my $sum = sum0(@divs);
	#say "w($n): sum of divisors $sum";
	return 0 if $sum < $n;

	#say "w($n): sum=$sum";

	my $nitems = @divs;

	my $two2n = 2**$nitems;

	for( my $i=0; $i<$two2n; $i++ )
	{
		my $b = sprintf("%0${nitems}b", $i );
		my @select = split( //, $b );

		my @chosen = map { $divs[$_] }
			grep { $select[$_] } 0..$#divs;
		$sum = sum0(@chosen);
		say "w($n): b=$b, select=", join(',',@select),
		    ", chosen=", join(',',@chosen),
		    ", sum=$sum" if $debug;

		return 0 if $sum == $n;
	}

	#say "$n is weird";
	return 1;
}

my $n = shift;
if( $tabulate )
{
	my $found=0;
	for( my $i=2; $found<$n; $i++ )
	{
		my $isweird = weird( $i );
		next unless $isweird;
		say "$i: weird";
		$found++;
	}
} else
{
	my $isweird = weird( $n );
	say "$n: weird? $isweird";
}
