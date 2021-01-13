#!/usr/bin/perl
#
# Task 2: "Vowel Strings
# 
# Write a script to accept an integer 1 <= N <= 5 that would print all
# possible strings of size N formed by using only vowels (a, e, i, o, u).
# 
# The string should follow the following rules:
# 
#     'a' can only be followed by 'e' or 'i'.
#     'e' can only be followed by 'i'.
#     'i' can only be followed by 'a', 'e', 'o', or 'u'.
#     'o' can only be followed by 'a' or 'u'.
#     'u' can only be followed by 'o' or 'e'.
# 
# For example, if the given integer N = 2 then script should print the following strings:
# 
# ae
# ai
# ei
# ia
# io
# iu
# ie
# oa
# ou
# uo
# ue
# "
# 
# My notes: reading "and" as "or" above, it sounds pretty simple as a generator.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;

die "vowel-strings N\n" unless @ARGV==1;
my $n = shift;
die "vowel-strings: N ($n) should be 1..5\n" unless $n>=1 && $n<=5;

my @vow = qw(a e i o u);

#
# generate( $prefix, $moresteps );
#	Generate and print all vowel strings starting with $prefix,
#	and taking $moresteps more generative steps, applying
#	the above rules at each step to extend the prefix.
#
fun generate( $prefix, $moresteps )
{
	if( $moresteps==0 )
	{
		say $prefix;
		return;
	}

	# 'a' can only be followed by 'e' or 'i'.
	if( $prefix =~ /a$/ )
	{
		generate( $prefix.'e', $moresteps-1 );
		generate( $prefix.'i', $moresteps-1 );
	}

	# 'e' can only be followed by 'i'.
	elsif( $prefix =~ /e$/ )
	{
		generate( $prefix.'i', $moresteps-1 );
	}

	# 'i' can only be followed by 'a', 'e', 'o', or 'u'.
	elsif( $prefix =~ /i$/ )
	{
		foreach my $vowel (@vow)
		{
			next if $vowel eq 'i';
			generate( $prefix.$vowel, $moresteps-1 );
		}
	}

	# 'o' can only be followed by 'a' or 'u'.
	elsif( $prefix =~ /o$/ )
	{
		generate( $prefix.'a', $moresteps-1 );
		generate( $prefix.'u', $moresteps-1 );
	}

	# 'u' can only be followed by 'o' or 'e'.
	elsif( $prefix =~ /u$/ )
	{
		generate( $prefix.'o', $moresteps-1 );
		generate( $prefix.'e', $moresteps-1 );
	}
}


foreach my $firstvowel (@vow)
{
	generate( $firstvowel, $n-1 );
}
