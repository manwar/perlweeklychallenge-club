#!/usr/bin/perl
# 
# TASK #2 - Square-free Integer
# 
# Write a script to generate all square-free integers <= 500.
# 
# In mathematics, a square-free integer (or squarefree integer) is an
# integer which is divisible by no perfect square other than 1. That is,
# its prime factorization has exactly one factor for each prime that
# appears in it. For example, 10 = 2 * 5 is square-free, but 18 = 2 *
# 3 * 3 is not, because 18 is divisible by 9 = 3**2.
# 
# Example
# 
# The smallest positive square-free integers are
#     1, 2, 3, 5, 6, 7, 10, 11, 13, 14, 15, 17, 19, 21, 22, 23, 26, 29, 30, ...
# 
# MY NOTES: also pretty easy.  The second definition above suggests using prime
# numbers, which is easy enough, especially as I have a prime generating module,
# but actually it's simpler to do it without primes as the first definition hints.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;

die "Usage: square-free-integers [--debug] [N default 500]\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV<2;

my $limit = shift // 500;


#
# my $squarefree = squarefree( $n );
#	Given a number $n, return 1 iff $n is a square free number,
#	ie. one divisible by no perfect square other than one.
#	Return 0 otherwise.
#
fun squarefree( $n )
{
	my $max = int(sqrt($n));
	foreach my $x (2..$max)
	{
		return 0 if $n % ($x*$x) == 0;
	}
	return 1;
}


my @sqfree = grep { squarefree($_) } 1..$limit;

say "The smallest positive square-free integers (up to $limit) are";

say join(', ', @sqfree);
