#!/usr/bin/perl
#
# Task 1: "kth Permutation Sequence
#
# Write a script to accept two integers n (>=1) and k (>=1). It should
# print the kth permutation of n integers. For more information, please
# follow the wiki page 
# 
# 	https://en.wikipedia.org/wiki/Permutation#k-permutations_of_n
# 
# (in summary: 'in other words, these k-permutations of n are the different
# ordered arrangements of a k-element subset of an n-set (sometimes called
# variations or 'arrangements' in the older literature.')
# 
# For example, n=3 and k=4, the possible permutation sequences are listed below:
# 
# 123
# 132
# 213
# 231
# 312
# 321
# 
# The script should print the 4th permutation sequence 231.
# "
# 
# My notes: The wiki definition defines k-from-n permutations as a LIST of
# all k-from-n partial permutations, whereas the example above shows something
# different: generate a single permutation: the Kth complete permutation
# sequence of 1..N.  So let's ignore the wiki, and go with the example.
# Obvious method: generate all permutations of 1..N in the above order, then
# pick the Kth one.  But that sounds roundabout.  Can we directly generate the
# Kth permutation I wonder?  After a bit of thought: yes we can.
# 

use feature 'say';
use strict;
use warnings;
use Function::Parameters;
#use Data::Dumper;

die "Usage: kth-perm-n k n\n" unless @ARGV == 2;

my( $k, $n ) = @ARGV;
die "kth-perm-n: n $n must be range 1..\n" unless $n>=1;

my $nperms = fact( $n );
die "kth-perm-n: k $k must be range 1..$nperms\n" unless $k>=1 && $k<=$nperms;

my $alldigits = join('', 1..$n);
my $permstr = nthperm( $k-1, $alldigits, $n, $nperms );
say "${k}th perm of $alldigits is $permstr";

#
# my $permstr = nthperm( $permno, $alldigits, $n, $nperms );
#	Return the $permno'th permutation (range 0..$nperms-1)
#	of $alldigits (length $n).
#
fun nthperm( $permno, $alldigits, $n, $nperms )
{
	if( $n==1 )
	{
		return substr( $alldigits, $permno, 1 );
	}
	my $w = $nperms / $n;

	my $firstdigit = substr( $alldigits, int($permno/$w), 1 );
	my $permstr = $firstdigit;
	$alldigits =~ s/$firstdigit//;
	$permstr .= nthperm( $permno%$w, $alldigits, $n-1, $nperms/$n );
	return $permstr;
}




#
# my $fact = fact( $n );
#	Calculate n!
#
fun fact( $n )
{
	my $result = 1;
	$result *= $_ for 1..$n;
	return $result;
}




