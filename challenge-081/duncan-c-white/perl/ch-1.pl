#!/usr/bin/perl
#
# Task 1: "Common Base String
# 
# You are given 2 strings, $A and $B.
# 
# Write a script to find out common base strings in $A and $B.
# 
# A substring of a string $S is called base string if repeated concatenation
# of the substring results in the string.
# 
# Example 1:
# 
# Input:
#     $A = "abcdabcd"
#     $B = "abcdabcdabcdabcd"
# 
# Output:
#     ("abcd", "abcdabcd")
# 
# Example 2:
# 
# Input:
#     $A = "aaa"
#     $B = "aa"
# 
# Output:
#     ("a")"
# 
# My notes: ok.  interesting.  sounds like a job for regex matching
# 

use strict;
use warnings;
use feature 'say';
use Data::Dumper;

die "Usage: common-base-strings a b\n" unless @ARGV==2;
my( $a, $b ) = @ARGV;

#
# my @base = find_base_strings( $str );
#	Find all base strings of $str, where a base string
#	is a substring that, if repeated some number of times,
#	makes up the string.
#
fun find_base_strings( $str )
{
	my $l = length($str);
	my @result;
	my %seensub;
	for( my $i=0; $i<$l; $i++ )
	{
		for( my $j=$i; $j<$l; $j++ )
		{
			# try substring from pos $i..$j
			my $sub = substr( $str, $i, 1+$j-$i );
			next if $seensub{$sub}++;
			next unless $str =~ /^($sub)+$/;
			#say "str=$str, sub=$sub";
			push @result, $sub;
		}
	}
	return @result;
}


my @abase = find_base_strings( $a );
#say Dumper \@abase;
my %abaseset = map { $_ => 1 } @abase;

my @bbase = find_base_strings( $b );
#say Dumper \@bbase;

my @common = grep { $abaseset{$_} } @bbase;
say for @common;
