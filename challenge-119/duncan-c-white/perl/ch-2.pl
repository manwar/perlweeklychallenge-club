#!/usr/bin/perl
# 
# Task 2: "Sequence without 1-on-1
# 
# Write a script to generate sequence starting at 1. Consider the increasing
# sequence of integers which contain only 1's, 2's and 3's, and
# do not have any doublets of 1's like below. Please accept a positive
# integer $N and print the $Nth term in the generated sequence.
# 
#     1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...
# 
# Example
# 
#   Input: $N = 5
#   Output: 13
# 
#   Input: $N = 10
#   Output: 32
# 
#   Input: $N = 60
#   Output: 2223
# "
# 
# My notes: hmm, depends on what we mean by "doublet", as in "no doublets of 1".
# I'm choosing to assume that it means "no two sequential 1s".  should be
# pretty easy - let's do it by generate and test.
#

use strict;
use warnings;
use feature 'say';
use List::Util qw(sum);
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;
die "Usage: seq-no-11 N\n" unless
	GetOptions( "debug" => \$debug ) && @ARGV==1;
my $n = shift;


#
# my $isterm = isterm( $x );
#	Test whether $x is a term in our sequence.
#	Return 1 iff it is; 0 otherwise.
#
fun isterm( $x )
{
	return 0 unless $x =~ /^[123]+$/;	# made up of 1,2 and 3s
	return 0 if $x =~ /11/;			# no sequence of 2 or more 1s
	return 1;
}


#
# my $nth = nthterm( $n );
#	Generate and return the $n th term in the above sequence.
#	Let's just do generate and test.
#
fun nthterm( $n )
{
	my $found = 0;
	my $i;
	for( $i=0; $found < $n; $i++ )
	{
		next unless isterm($i);
		$found++;
		say "debug: term $found is $i" if $debug;
	}
	return $i-1;
}


my $nth = nthterm( $n );
say $nth;
