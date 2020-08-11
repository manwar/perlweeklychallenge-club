#!/usr/bin/perl
#
# Task 1: "Flip Binary
#
# You are given a binary number B, consisting of N binary digits 0 or 1: s0, s1
# .. s(N-1).
# 
# Choose two indices L and R such that 0 <= L <= R < N and flip the digits s(L),
# s(L+1) .... s(R). By flipping, we mean change 0 to 1 and vice-versa.
# 
# For example, given the binary number 010, the possible flip pair results
# are listed below:
# 
#     L=0, R=0 the result binary: 110
#     L=0, R=1 the result binary: 100
#     L=0, R=2 the result binary: 101
#     L=1, R=1 the result binary: 000
#     L=1, R=2 the result binary: 001
#     L=2, R=2 the result binary: 011
# 
# Write a script to find the indices (L,R) that results in a binary number
# with maximum number of 1s. If you find more than one maximal pair L,R
# then print all of them.
# 
# Continuing our example, note that we had three pairs (L=0, R=0), (L=0,
# R=2), and (L=2, R=2) that resulted in a binary number with two 1s,
# which was the maximum. So we would print all three pairs.
# 
# My notes: sounds interesting.  Do we need to first compute the maximum
# numbers of 1s and then compute all (L,R) pairs having that value? Hopefully
# not.
#

use feature 'say';
use strict;
use warnings;
use Function::Parameters;

die "Usage: flip-binary BINSTR\n" unless @ARGV == 1;

my $b = shift;
die "flip-binary: b $b must be non-empty [01]+\n" unless $b =~ /^[01]+$/;

my $maxbit = length($b)-1;

my $longest = -1;
my @longestlrs;

foreach my $l (0..$maxbit)
{
	foreach my $r ($l..$maxbit)
	{
		my $flippedbinstr = flip( $b, $l, $r );
		my $ones = ($flippedbinstr =~ tr/1//);
		say "flip $b $l $r == $flippedbinstr, $ones ones";
		if( $ones > $longest )
		{
			@longestlrs = ( [$l,$r,$flippedbinstr] );
			$longest = $ones;
		} elsif( $ones == $longest )
		{
			push @longestlrs, [$l,$r,$flippedbinstr];
		}
	}
}

say "for $b, longest no ones=$longest";
foreach my $lr (@longestlrs)
{
	my( $l, $r, $f ) = @$lr;
	say " $l..$r: $f";
}



#
# my $flippedbinstr = flip( $binstr, $l, $r );
#	Given a binary string $binstr, and bit positions $l and $r
#	(each in range 0..length(binstr)-1), flip bits between positions
#	$l..$r and return the "flipped binary string".
#
fun flip( $binstr, $l, $r )
{
	my $maxbit = length($binstr)-1;
	die "flip: l $l must be 0..$maxbit\n" unless $l>=0 && $l<=$maxbit;
	die "flip: r $r must be 0..$maxbit\n" unless $r>=0 && $r<=$maxbit;
	die "flip: r $r must be >= l $l\n" unless $r>=$l;
	for( my $pos=$l; $pos<=$r; $pos++ )
	{
		my $bit = substr($binstr,$pos,1);
		$bit = 1-$bit;
		substr( $binstr,$pos,1 ) = $bit;
	}
	return $binstr;
}


