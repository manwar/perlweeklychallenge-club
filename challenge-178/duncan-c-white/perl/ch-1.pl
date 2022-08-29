#!/usr/bin/perl
# 
# Task 1: Quater-imaginary Base
# 
# Write a script to convert a given number (base 10) to quater-imaginary
# base number and vice-versa. For more informations, please checkout
# the wiki page: https://en.wikipedia.org/wiki/Quater-imaginary_base
# 
# For example,
# 
# $number_base_10 = 4
# $number_quater_imaginary_base = 10300
# 
# MY NOTES: seriously?  base -2i, and for task 1?  what was Knuth smoking
# in 1960?  First, we have to define "number" more carefully.  I'm going to
# choose "positive integer", because that reduces the problem from base -2i
# to base -4 with zeroes between every pair of digits, and that's already
# much too horrible for a "task 1".
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;


my $debug=0;
die "Usage: to-from-quater-imaginary-base [--debug] to|from|check N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;

my $dir = shift;		# to/from/check..
my $n = shift;


#
# my $b4 = convert_to_base_neg4( $x );
#	Convert +int $x to base -4, return the base-4 numeral.
#
fun convert_to_base_neg4( $x )
{
	my $origx = $x;
	my $b4 = "";
	while( abs($x)>0 )
	{
		my $d = int($x/-4);
		my $m = $x + 4*$d;
		if( $m < 0 )
		{
			$m += 4;
			$d++;
		}
		say "debug: c_t_b-4($origx): x=$x, d=$d, m=$m" if $debug;
		$b4 .= $m;
		$x = $d;
	}
	$b4 = reverse($b4);
	$b4 = '0' if $b4 eq '';
	say "debug: c_t_b-4($origx): result = $b4" if $debug;
	return $b4;
}


#
# my $qistr = convert_to( $n );
#	Convert +int $n to q-i, return the q-i numeral.
#
fun convert_to( $n )
{
	my $b4 = convert_to_base_neg4( $n );
	my $str = $b4;
	$str =~ s/(\d)/${1}0/g;
	chop $str;
	return $str;
}


#
# my $n = convert_from( $qinum );
#	Given a q-i numeral $qinum (a string using only digits 0..3),
#	convert it from q-i to a plain +int.
#
fun convert_from( $qinum )
{
	my $n = 0;
	my $len = length($qinum)-1;

	# convert $qinum into a base -4 string, checking that the
	# imaginary columns in $qinum are all 0 as we go.
	my $bstr = "";
	for( my $pos=$len; $pos>=0; $pos-- )
	{
		my $d = substr($qinum,$pos,1);
		if( $pos%2 == 1 )
		{
			die "convert_from( $qinum ): digit $d at pos $pos ".
			    "should be zero\n" unless $d eq '0';
		} else
		{
			$bstr .= $d;
		}
	}
	$bstr = reverse($bstr);
	$bstr = '0' if $bstr eq '';
	say "debug: cf($qinum), bstr = $bstr" if $debug;

	# now convert that..
	return convert_from_base_neg4( $bstr );
}


#
# my $n = convert_from_base_neg4( $bstr );
#	Given $bstr, a base -4 numeral representing a +int,
#	return that int.
#
fun convert_from_base_neg4( $bstr )
{
	my $n = 0;
	my $currpow = 1;
	my $len = length($bstr)-1;
	for( my $pos=$len; $pos>=0; $pos-- )
	{
		my $d = substr($bstr,$pos,1);
		say "debug: c_f_b-4($bstr): digit $d, currpow $currpow, ".
		    "n $n" if $debug;
		$n += $d * $currpow;
		$currpow *= -4;
	}
	say "debug: c_f_b-4($bstr): result is $n" if $debug;
	return $n;
}


#say convert_to_base_neg4( $n );
#exit 0;

if( $dir eq "to" )
{
	die "to-from-quater-imaginary-base: to $n: must be +int\n"
		unless $n>=0 && $n == int($n);
	my $cistr = convert_to($n);
	say $cistr;
	#say "converted back to int: ". convert_from($cistr);
} elsif( $dir eq "from" )
{
	die "to-from-quater-imaginary-base: from $n: all digits must be 0..3\n"
		unless $n =~ /^[0-3]+$/;
	say convert_from($n);
} elsif( $dir eq "check" )
{
	die "to-from-quater-imaginary-base: check $n: must be +int\n"
		unless $n>=0 && $n == int($n);
	say "checking first $n conversions back-convert ok";
	foreach my $x (0..$n)
	{
		my $cistr = convert_to($x);
		#say $cistr;
		my $back = convert_from($cistr);
		die "check: x=$x, qi($x)=$cistr, back($cistr)=$back\n"
			unless $x==$back;
	}
} else
{
	die "to-from-quater-imaginary-base: direction $dir must be ".
	    "to or from or check\n";
}
