#!/usr/bin/perl

# Challenge 2: Write a script to demonstrate Mutually Recursive methods. Two
# methods are mutually recursive if the first method calls the second and
# the second calls first in turn. Using the mutually recursive methods,
# generate Hofstadter Female and Male sequences.
# 
#  F ( 0 ) = 1   ;   M ( 0 ) = 0
#  F ( n ) = n - M ( F ( n - 1 ) ) , n > 0
#  M ( n ) = n - F ( M ( n - 1 ) ) , n > 0."
# 
#  My notes:

#  Ok, looks straight forward enough, and I always liked Douglas Hofstadter
#  and especially his book Godel, Esher and Bach.  Initially, I did it as
#  straightforward mutually recursive functions, but then I added Memoize
#  optimization when I realized how slow it gets as N increases (eg to 80..)..

use strict;
use warnings;
use Function::Parameters;
use Memoize;
use Data::Dumper;

#
# my $value = male( $n );
#	Generate and return the value of Hofstdter's male sequence for $n.
# rules:
#  F ( 0 ) = 1   ;   M ( 0 ) = 0
#  F ( n ) = n - M ( F ( n - 1 ) ) , n > 0
#  M ( n ) = n - F ( M ( n - 1 ) ) , n > 0."
#
fun male( $n )
{
	die "male( $n ): n must be >= 0\n" unless $n>=0;
	return 0 if $n==0;
	return $n - female( male( $n-1 ) );
}


#
# my $value = female( $n );
#	Generate and return the value of Hofstdter's female sequence for $n.
# rules:
#  F ( 0 ) = 1   ;   M ( 0 ) = 0
#  F ( n ) = n - M ( F ( n - 1 ) ) , n > 0
#  M ( n ) = n - F ( M ( n - 1 ) ) , n > 0."
#
fun female( $n )
{
	die "female( $n ): n must be >= 0\n" unless $n>=0;
	return 1 if $n==0;
	return $n - male( female( $n-1 ) );
}


memoize( 'male' );
memoize( 'female' );

die "Usage: ch-2.pl maxN\n" unless @ARGV==1;
my $maxn = shift;

foreach my $n (0..$maxn)
{
	my $mv = male( $n );
	my $fv = female( $n );
	print "male($n) = $mv, female($n) = $fv\n";
}
