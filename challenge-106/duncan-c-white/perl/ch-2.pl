#!/usr/bin/perl
# 
# Task 2: "Decimal String
# 
# You are given numerator and denominator i.e. $N and $D.
# 
# Write a script to convert the fraction into decimal string. If the
# fractional part is recurring then put it in parenthesis.
# 
# Example
# 
# 	Input: $N = 1, $D = 3
# 	Output: "0.(3)"
# 
# 	Input: $N = 1, $D = 2
# 	Output: "0.5"
# 
# 	Input: $N = 5, $D = 66
# 	Output: "0.0(75)"
# "
# 
# My notes: the recurring bit is of course the core of this problem.
# How to do it?  Refreshing my memory with some examples of long
# division (sad), I realise that if we've seen the remainder before
# the recurring part is from where we saw that remainder before to
# the end of the digits produced.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
#use Data::Dumper;

my $debug = 0;
die "Usage: decimal-string [--debug] N D\n"
	unless GetOptions("debug"=>\$debug) && @ARGV==2;


my( $n, $d ) = @ARGV;

#
# my $frac = fraction( $n, $d );
#	Compute the fraction n/d, as a decimal string,
#	but in the case of a recurring fraction, represent
#	the recurring sequence as (seq).  examples given above.
#
fun fraction( $n, $d )
{
	die "fraction($n, $d): cannot divide by 0\n" if $d==0;

	my $result = "";

	# deal with any sign..
	if( $d < 0 )
	{
		$n = -$n; $d = -$d;
	}
	if( $n < 0 )
	{
		$result = "-";
		$n = -$n;
	}
	# now both are positive

	# deal with the integer part.
	my $intpart = int($n/$d);
	$result .= $intpart;
	$n -= $intpart * $d;
	if( $n != 0 )
	{
		$result .= ".";

		# now deal with the fractional part
		$result .= recurring( $n, $d );
	}
	return $result;
}


#
# my $result = recurring( $n, $d );
#	Given $n and $d, where both are +ve, $d is not zero,
#	and $n < $d, representing a fraction n/d in the range
#	0 to 0.9999.., generate a string showing that fraction
#	with any recurring sequence shown as (seq).
#
fun recurring( $n, $d )
{
	my @seen;	# maps any value of n we've seen -> it's position
	my $digits="";
	my $rem = $n;

	$seen[$rem] = 0;
	$rem *= 10;
	for( my $pos=0; $rem!=0 && ! defined $seen[$rem]; $pos++ )
	{
		my $intpart = int($rem / $d);
		$digits .= $intpart;
		say "rem:$rem intpart:$intpart digits:$digits" if $debug;
		$seen[$rem] = $pos;
		$seen[$rem] = length($digits)-1;
		$rem -= $intpart*$d;
		$rem *= 10;
	}
	return $digits if $rem==0;		# not repeating

	my $repstart = $seen[$rem];
	say "rem:$rem repstart:$repstart" if $debug;

	# the digits from pos $repstart to end are repeating

	my $nonrep = substr($digits,0,$repstart);
	my $rep = substr($digits,$repstart);
	return "$nonrep($rep)";
}


my $frac = fraction( $n, $d );
say $frac;
