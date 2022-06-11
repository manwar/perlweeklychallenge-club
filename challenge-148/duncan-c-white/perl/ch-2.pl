#!/usr/bin/perl
# 
# TASK #2 - Cardano Triplets
# 
# Write a script to generate first 5 Cardano Triplets.
# 
# A triplet of positive integers (a,b,c) is called a Cardano Triplet if
# it satisfies the below condition.
# 
#   cuberoot(a+b.sqrt(c)) + cuberoot(a-b.sqrt(c)) = 1
# 
# Example
# 
# (2,1,5) is the first Cardano Triplet.
# 
# MY NOTES: Ok, two mildly tricky things:
# 1. real arithmetic means "=" is imprecise, we can't even use rationals as
#    sqrt() and cuberoot() are involved, and
# 2. (2,1,5) is the "first" Cardano triplet - in what order?
# 
# The answer to the latter question will set the basic structure
# of the program.  Perhaps we should "order by minimum sum of triplet numbers"?
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
my $epsilon = 1e-7;

#
# my $root = cuberoot($x);
#	Return the cuberoot of $x; make sure it works even if $x<0
#
sub cuberoot ($)
{
	my( $x ) = @_;
	my $r = abs($x)**(1/3);
	$r = -$r if $x<0;
	return $r;
}


#
# my $isc = is_cardano($a,$b,$c);
#	Return 1 iff $a,$b,$c is a Cardano triplet; 0 otherwise.
#	Recall that a Cardano triplet has:
#	cuberoot(a+b.sqrt(c)) + cuberoot(a-b.sqrt(c)) = 1
#
sub is_cardano ($$$)
{
	my( $a, $b, $c ) = @_;
	my $x = $b * sqrt($c);
	my $q = cuberoot($a+$x) + cuberoot($a-$x);
	#say "iscard($a,$b,$c): x=$x, q=$q";

	return abs( $q-1 ) <= $epsilon ? 1 : 0;
}


#say is_cardano(2,1,5);
#exit 0;

die "Usage: first-N-cardano-triplets [--debug] [N default 5]\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV<2;

my $n = shift // 5;

my $nfound = 0;

for( my $sum=3; $nfound < $n; $sum++ )
{
	# find all Cardano triplets whose sum is $sum
	say "find all Cardano triplets with sum $sum" if $debug;
	for( my $a=1; $a<$sum-1; $a++ )
	{
		for( my $b=1; $a+$b<$sum; $b++ )
		{
			my $c = $sum-$a-$b;
			die "bad structure, a=$a, b=$b, c=$c\n"
				if $c<1;
			#say "$a,$b,$c";
			next unless is_cardano($a,$b,$c);
			$nfound++;
			say "Found $a,$b,$c";
		}
	}
}
