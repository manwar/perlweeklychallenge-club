#!/usr/bin/perl
# 
# Task 1: "Rare Numbers
# 
# You are given a positive integer $N.
# 
# Write a script to generate all Rare numbers of size $N if exists. Please
# read http://www.shyamsundergupta.com/rare.htm for more information about it.
# 
# Examples
# 
# (a) 2 digits: 65
# (b) 6 digits: 621770
# (c) 9 digits: 281089082
# "
# 
# My notes: ok, interesting question.  In summary: R (a +ve no) is a Rare No
# iff R + reverse(R) and R - reverse(R) are both perfect squares.
# So: generate and test time.  This is optimised version 1b: Different way of
# doing 1a's optimization (rare numbers start with even top digit).  Skip
# numbers with odd top digit altogether (so don't even consider 1...., 3....
# etc!  rareblock( 2 ) tests all 2.... numbers etc..
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;
die "Usage: rare-numbers [--debug] N\n"
	unless GetOptions( "debug" => \$debug )
	    && @ARGV==1;

my $n = shift;


#
# my $isperfect = perfectsquare( $n );
#	Return 1 iff $n is a perfect square, 0 otherwise.
#
fun perfectsquare( $n )
{
	return 0 if $n<0;
	my $s = int(sqrt($n));
	return $n == $s * $s;
}


#
# my $israre = israre( $x );
#	Return 1 iff $x is rare, 0 otherwise.
#
fun israre( $x )
{
	my $r = reverse $x;
	return 0 if $r > $x;	# cos x-r is negative, so not perfect square
	return perfectsquare( $x + $r ) && perfectsquare( $x - $r );
}


#
# rareblock( $m, $f );
#	Check all numbers in range $f * $m .. ($f+1) * $m - 1
#	for rare-ness.
#
fun rareblock( $m, $f )
{
	my $from = $m * $f;
	my $to = $m * ($f+1) - 1;

	say "$from..$to" if $debug;

	foreach my $x ($from..$to)
	{
		say "rare $x" if israre($x);
	}
}


my $base = 10**($n-1);

rareblock( $base, 2 );
rareblock( $base, 4 );
rareblock( $base, 6 );
rareblock( $base, 8 );
