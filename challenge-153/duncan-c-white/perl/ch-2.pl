#!/usr/bin/perl
# 
# TASK #2 - Factorions
# 
# You are given an integer, $n.
# 
# Write a script to figure out if the given integer is factorion.
# 
# A factorion is a natural number that equals the sum of the factorials of its digits.
# 
# Example 1:
# 
#   Input: $n = 145
#   Output: 1
# 
#     Since 1! + 4! + 5! => 1 + 24 + 120 = 145
# 
# Example 2:
# 
#   Input: $n = 123
#   Output: 0
# 
#     Since 1! + 2! + 3! => 1 + 2 + 6 <> 123
# 
# MY NOTES: cool, precompute 0..9! in a 10 element array, split number into
# decimal digits, sum their factorials and check if the result if the number you
# first thought of.  Let's add a tabulating mode (invoked if --tab given) that
# shows, which numbers (1..$n) are factorian.  Running this as:
#	./ch-2.pl -t 1000000
# reveals that the only base 10 factorians under 1000000 are:
#       1, 2, 145, 40585
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use List::Util qw(sum);
#use Data::Dumper;

my $debug=0;
my $tabulate=0;


# calculate 0..9! in @df.
my $fact = 1;
my @df;
map { push @df, $fact; $fact *= $_ } 1..10;
#say join( ', ', @df );
#die;


#
# my $sum = sumfactdigits( $x );
#	Add up the factorials of the individual decimal digits of $x;
#	return the sum.
#
fun sumfactdigits( $x )
{
	my @d = split( //, $x );
	return sum( map { $df[$_] } @d );
}

#
# my $isfactorian = isfactorian( $x );
#	Return 1 iff $x is factorian (i.e. sumfactdigits($x)==$x);
#	return 0 otherwise.
#
fun isfactorian( $x )
{
	my $sum = sumfactdigits( $x );
	return $sum == $x ? 1 : 0;
}


die "Usage: is-factorian [--debug] [--tabulate] N\n" unless
	GetOptions( "debug" => \$debug, "tabulate" => \$tabulate ) && @ARGV==1;
my $n = shift;


if( $tabulate )
{
	my @isf = grep { isfactorian($_) } 1..$n;
	say join( ', ', @isf );
} else
{
	say isfactorian($n);
}
