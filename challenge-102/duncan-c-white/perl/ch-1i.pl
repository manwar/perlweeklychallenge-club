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
# So: generate and test time.  This is optimized version 1i: 
# try reintroducing israre() but with the inlined perfectsquare() in it
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
#fun perfectsquare( $n )
#{
#	my $s = int(sqrt($n));
#	return $n == $s * $s ? 1 : 0;
#}


#
# my $israre = israre( $x );
#	Return 1 iff $x is rare, 0 otherwise.
#
fun israre( $x )
{
	my $r = reverse $x;
	return 0 if $x<$r; # if x-r is negative, not perfect square
	# inlined perfectsquare() in: return 0 unless perfectsquare( $x + $r );
	my $n = $x+$r;
	my $s = int(sqrt($n));
	return 0 unless $n == $s * $s;

	# inlined perfectsquare() in: return 0 unless perfectsquare( $x - $r );
	$n = $x-$r;
	$s = int(sqrt($n));
	return 0 unless $n == $s * $s;
}


#
# rareblock( $m, $f, $lastdigit );
#	Check all numbers in range $f * $m .. ($f+1) * $m - 1
#	whose last digit is $lastdigit for rare ness.
#
fun rareblock( $m, $f, $lastdigit )
{
	return if $lastdigit > $f;	# reverse(y) > y => y not rare

	my $from = $f * $m;
	my $to = ($f+1) * $m - 1;
	say "$from..$to" if $debug;

	$from /= 10;
	$to /= 10;

	foreach my $y ($from..$to)
	{
		my $x = $y*10 + $lastdigit;
		say "rare $x" if israre($x);
	}
}


#
# rareblock05( $m, $f );
#	Check all numbers in range $f * $m .. ($f+1) * $m - 1
#	whose last digit is 0 or 5 for rare ness.
#
fun rareblock05( $m, $f )
{
	my $from = $f * $m;
	my $to = ($f+1) * $m - 1;
	say "$from..$to" if $debug;

	$from /= 10;
	$to /= 10;

	foreach my $y ($from..$to)
	{
		foreach my $d (0,5)
		{
			my $x = $y*10+$d;
			say "rare $x" if israre($x);
		}
	}
}


#
# rareblock2378( $m, $f );
#	Check all numbers in range $f * $m .. ($f+1) * $m - 1
#	whose last digit is 2, 3, 7 or 8 for rare ness.
#
fun rareblock2378( $m, $f )
{
	my $from = $f * $m;
	my $to = ($f+1) * $m - 1;
	say "$from..$to" if $debug;
	$from /= 10;
	$to /= 10;

	foreach my $y ($from..$to)
	{
		# try appending 2, 3, 7 and 8 and checking for rareness
		foreach my $d (2,3,7,8)
		{
			my $x = $y * 10 + $d;
			say "rare $x" if israre($x);
		}
	}
}


my $base = 10**($n-1);

rareblock( $base, 2, 2 );
rareblock( $base, 4, 0 );
rareblock05( $base, 6 );
rareblock2378( $base, 8 );
