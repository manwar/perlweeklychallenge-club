#!/usr/bin/perl
#
# Task 2: "Interleave String
# 
# You are given 3 strings; $A, $B and $C.
# 
# Write a script to check if $C is created by interleave $A and $B.
# 
# Print 1 if check is success otherwise 0.
#
# Example 1:
# 
# Input:
#     $A = "XY"
#     $B = "X"
#     $C = "XXY"
# 
# Output: 1
# 
# EXPLANATION
# 
# "X" (from $B) + "XY" (from $A) = $C
# 
# Example 2:
# 
# Input:
#     $A = "XXY"
#     $B = "XXZ"
#     $C = "XXXXZY"
# 
# Output: 1
# 
# EXPLANATION
# 
# "XX" (from $A) + "XXZ" (from $B) + "Y" (from $A) = $C
# 
# Example 3:
# 
# Input:
#     $A = "YX"
#     $B = "X"
#     $C = "XXY"
# 
# Output: 0
# 
# My notes: It's not quite clear what "interleaving" means here, but I'm
# going to assume that it means "take a PREFIX of any length from one string,
# followed by a PREFIX of any length from the other string, then continue
# with the parts of the strings not yet consumed".  Relatively easy.
# 

use strict;
use warnings;
use Function::Parameters;
use feature 'say';
use Data::Dumper;

die "Usage: interleave-string a b c\n" unless @ARGV==3;
my( $a, $b, $c ) = @ARGV;

# could start with a prefix of $a, or a prefix of $b.

#
# my $isinterleaved = interleave( $a, $b, $c );
#	Return 1 iff $c is a result of interleaving variable length prefixes
#	of $a and $b, with the prefix of $a coming FIRST.  Return 0 otherwise.
#
fun interleave( $a, $b, $c )
{
	my $l = length($a);
	foreach my $i (1..$l)
	{
		my $pre = substr($a,0,$i);
		my $cpre = substr($c,0,$i);
		next unless $pre eq $cpre;
		my $arest = substr($a,$i);
		my $crest = substr($c,$i);
		say "debug: found possible prefix $pre (len $i) of $a and $c, leaving $arest, $b, $crest";
		return 1 if $crest eq "" || interleave( $b, $arest, $crest );
	}
	return 0;
}


my $isinterleaved = interleave( $a, $b, $c ) || interleave( $b, $a, $c );
say $isinterleaved;
