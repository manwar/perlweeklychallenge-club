#!/usr/bin/perl
# 
# Task 2: Perfect Totient Numbers
# 
# Write a script to generate first 20 Perfect Totient Numbers. Please
# checkout the following wikipedia page for more information:
# 
#   https://en.wikipedia.org/wiki/Perfect_totient_number
# 
# Explanation gleaned from those notes:
# 
# A perfect totient number is an integer that is equal to the sum of its
# iterated totients. That is, we apply the totient function to a number n,
# apply it again to the resulting totient, and so on, until the number 1
# is reached, and add together the resulting sequence of numbers; if the
# sum equals n, then n is a perfect totient number.
# 
# The totient function counts the positive integers up to a given integer
# n that are relatively prime to n.  In other words, it is the number of
# integers k in the range 1 <= k <= n for which gcd(n, k) is equal to 1.
# 
# For example, there are six positive integers less than 9 and relatively
# prime to it, so the totient of 9 is 6; there are two numbers less than
# 6 and relatively prime to it, so the totient of 6 is 2; and there is one
# number less than 2 and relatively prime to it, so the totient of 2 is 1;
# and 9 = 6 + 2 + 1, so 9 is a perfect totient number.
# 
# Output
# 
# 3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471, 729,
# 2187, 2199, 3063, 4359, 4375, 5571
# 
# MY NOTES: given a gcd() function it seems relatively straightforward.
# We last used gcd() in challenge 136, so let's re-use our implementation.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Function::Parameters;

my $debug=0;
die "Usage: first-n-perfect-totient-numbers [--debug] [N default 20]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;


#
# my $gcd = gcd( $a, $b );
#       Compute and return the GCD (Greatest Common Denominator) of $a and $b.
#
fun gcd( $a, $b )
{
        while( $b != 0 )
        {
                ( $a, $b ) = ( $b, $a % $b );
        }
        return $a;
}


#
# my $ntot = totient( $n );
#	This function counts the positive integers up to $n that are
#	relatively prime to $n.  In other words, it is the number of
#	values in the range 1 <= k <= n for which gcd(n, k) == 1.
#
fun totient( $n )
{
	my $result = 0;
	foreach my $k (1..$n)
	{
		$result++ if gcd($n,$k)==1;
	}
	return $result;
}


#say totient(9);
#say totient(6);
#say totient(2);

#
# my $isptn = is_perfect_totient_number( $n );
#	A perfect totient number is an integer that is equal to the sum
#	of its iterated totients. That is, we apply the totient function
#	to a number n, apply it again to the resulting totient, and so on,
#	until the number 1 is reached, and add together the resulting
#	sequence of numbers; iff the sum equals n, then n is a perfect totient
#	number.
#
fun is_perfect_totient_number( $n )
{
	my $sum = 0;
	my $x = $n;
	do {
		$x = totient($x);
		$sum += $x;
		say "debug: x=$x, sum=$sum" if $debug;
	} while( $x != 1 );
	return $sum==$n?1:0;
}


my $firstn = shift // 20;
my @found;
for( my $i=2; @found<$firstn; $i++ )
{
	push @found, $i if is_perfect_totient_number( $i );
}

say join( ', ', @found );
