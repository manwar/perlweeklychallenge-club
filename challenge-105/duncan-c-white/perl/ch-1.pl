#!/usr/bin/perl
# 
# Task 1: "Nth root
# 
# You are given positive numbers $N and $k.
# 
# Write a script to find out the $Nth root of $k. For more information,
# please take a look at
# https://en.wikipedia.org/wiki/Nth_root#Computing_principal_roots
# 
# Example
# 
# 	Input: $N = 5, $k = 248832
# 	Output: 12
# 
# 	Input: $N = 5, $k = 34
# 	Output: 2.02
# "
# 
# My notes: ok, dull but easy, using the Newton-Raphson Method.
# 

use strict;
use warnings;
use Function::Parameters;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: nthroot [--debug] N K\n"
	unless GetOptions( "debug" => \$debug ) && @ARGV==2;

my $epsilon = 1e-8;


#
# my $root = nthroot( $n, $a );
#	Find the $n th root of $a.  Return the result.
#
fun nthroot( $n, $a )
{
	my $x = $a/2;	# guess
	while( abs($x**$n-$a) > $epsilon )
	{
		say "debug: ${n}th root of $a approx $x" if $debug;
		$x = ( ($n-1)*$x + $a/$x**($n-1) ) / $n;
	}
	return $x;
}


my( $n, $k ) = @ARGV;
my $root = nthroot( $n, $k );
say "${n}th root of $k is $root";
