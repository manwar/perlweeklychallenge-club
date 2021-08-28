#!/usr/bin/perl
# 
# Task 1: "Pythagorean Triples
# 
# You are given a positive integer $N.
# 
# Write a script to print all Pythagorean Triples containing $N as a
# member. Print -1 if it can't be a member of any. i
# 
# Triples with the same set of elements are considered the same, i.e. if
# your script has already printed (3, 4, 5), (4, 3, 5) should not be
# printed.
# 
# The famous Pythagorean theorem states that in a right angle triangle,
# the length of the two shorter sides and the length of the longest
# side are related by a2+b2 = c2.
# 
# A Pythagorean triple refers to the triple of three integers whose lengths
# can compose a right-angled triangle.
# 
# Example
# 
#     Input: $N = 5
#     Output:
#         (3, 4, 5)
#         (5, 12, 13)
# 
#     Input: $N = 13
#     Output:
#         (5, 12, 13)
#         (13, 84, 85)
# 
#     Input: $N = 1
#     Output:
#         -1
# "
# 
# My notes: the tricky part here is knowing how to generate all Pythagorean
# triples that MIGHT contain $N, i.e. when to stop generating triples..
# I think, when you've checked a + b, if int(sqrt(a*a+b*b))==b then stop
# considering bigger b values.
#

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

my $debug=0;
die "Usage: pythagorean triples N\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $n = shift;
die "pt: N ($n) must be > 0\n" unless $n>0;

my $found = 0;
foreach my $a (1..$n)
{
	my $a2 = $a * $a;
	for( my $b = $a+1; ; $b++ )
	{
		last if $a < $n && $b > $n;	# fallen off

		#say "trying a=$a, b=$b";
		my $b2 = $b * $b;
		my $sum = $a2 + $b2;
		my $c = int(sqrt($sum));

	if( $c == $b )				# fallen off
	{
		say "found upper limit for a=$a: b=$b" if $debug;
		last;
	}

		next unless $sum == $c * $c;
		next unless $a==$n || $b==$n || $c==$n;
		say "found $a $b $c";
		$found++;
	}
}
say "-1" unless $found;
