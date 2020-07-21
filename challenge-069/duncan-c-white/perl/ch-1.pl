#!/usr/bin/perl
#
# Task 1: "Strobogrammatic Number
#
# A strobogrammatic number is a number that looks the same when looked at
# upside down.
# 
# You are given two positive numbers $A and $B such that 1 <= $A <= $B <= 10^15.
# 
# Write a script to print all strobogrammatic numbers between the given
# two numbers.
# 
# Example
# 
# Input: $A = 50, $B = 100
# Output: 69, 88, 96
# "
# 
# My notes: ok.  Wikipedia suggests 0, 1, 6, 8 and 9 are only digits to
# consider, 0, 1 and 8 are their own inverses, 6 and 9 form the only
# inverse pair (unless you include 2 and 5 like on an 8-segment lcd display).
#

use strict;
use warnings;
use feature 'say';
use List::MoreUtils qw(pairwise any);
use Function::Parameters;
use Data::Dumper;

die "Usage: strobogrammatic M N\n" unless @ARGV==2;

my %inverse = qw(0 0 1 1 8 8 6 9 9 6);

#
# my $isstrobo = strobo( $x );
#	Return 1 iff $x is strobogrammatic, else 0.
#
fun strobo( $x )
{
	return 0 if $x =~ /[2-57]/;
	my @d = split(//,$x);
	my @r = reverse @d;
	my @ok = pairwise { 
		#say "debug: a=$a, b=$b, inverse(a)=$inverse{$a}";
		$inverse{$a} == $b ? 1 : 0
	} @d, @r;
	#say "debug: ok=", join(',',@ok);
	return 0 if any { $_ == 0 } @ok;
	return 1;
}



my( $m, $n ) = @ARGV;

say "strobogrammatic numbers between $m and $n are:";

foreach my $i ($m..$n)
{
	say $i if strobo($i);
}
