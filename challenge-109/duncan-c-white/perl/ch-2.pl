#!/usr/bin/perl
# 
# Task 2: "Four Squares Puzzle
# 
# You are given four squares as below with numbers named a,b,c,d,e,f,g.
# 
#               (1)                    (3)
#         ===============     ===============
#         |             |     |             |
#         |     a       |     |     e       |
#         |             |(2)  |             | (4)
#         |         ---------------     --------------
#         |         |   |     |   |     |   |        |
#         |         | b |     | d |     | f |        |
#         |         |   |     |   |     |   |        |
#         |         |   |     |   |     |   |        |
#         ==========|====     ====|==========        |
#                   |      c      |     |     g      |
#                   |             |     |            |
#                   |             |     |            |
#                   ---------------     --------------
# 
# Write a script to place the given unique numbers in the square box so
# that sum of numbers in each box is the same.
# 
# Example
# 
# Input: 1,2,3,4,5,6,7
# 
# Output:
# 
#     a = 6
#     b = 4
#     c = 1
#     d = 5
#     e = 2
#     f = 3
#     g = 7
# 
#     Box 1: a + b = 6 + 4 = 10
#     Box 2: b + c + d = 4 + 1 + 5 = 10
#     Box 3: d + e + f = 5 + 2 + 3 = 10
#     Box 4: f + g = 3 + 7 = 10
# "
# 
# My notes: sounds simple enough.  Find a,b,c,d,e,f st a+b = b+c+d = d+e+f = f+g
# Of course, we'll need to try all permutations of the values given.  There
# are lots of CPAN modules (eg. Algorithm::Permute), but here I generate the
# permutations myself via Rosetta Stone code..
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
#use Data::Dumper;

my $debug = 0;
die "Usage: four-squares [--debug] 7 values\n"
	unless GetOptions("debug"=>\$debug) && @ARGV==7;
my @v = @ARGV;


#
# allpermutations( \&eachpermcallback, $perm, @v );
#	compute all permutations of @v with $perm on the front,
#	calling eachpermcallback for each permutation found.
#	Adapted from Rosetta Stone..
#
fun allpermutations( $cb, $perm, @v )
{
	if( @v == 0 )
	{
		$cb->( @$perm );
		return;
	}
	foreach my $i (0..$#v)
	{
		# remove $v[$i] from the values, append it to the @$perm
		allpermutations( $cb,
			[ @$perm, $v[$i] ],
			@v[0..$i-1], @v[$i+1..$#v] );
	}
}

#
# printifsolution( @perm );
#	check whether @perm (7 values) is a four-square solution;
#	print it if so.
#
fun printifsolution( @perm )
{
	die unless @perm==7;
	my( $a, $b, $c, $d, $e, $f, $g ) = @perm;
	my $sum = $a+$b;
	return unless $sum == $b+$c+$d && $sum == $d+$e+$f && $sum == $f+$g;
	say "solution: a=$a, b=$b, c=$c, d=$d, e=$e, f=$f, g=$g";
}

allpermutations( \&printifsolution, [], ,@v );
