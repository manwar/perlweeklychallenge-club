#!/usr/bin/perl
#
# Task 2: "FNR Character
#
# You are given a string $S.
# 
# Write a script to print the series of first non-repeating character (left -> right) for the given string. Print # if none found.
# 
# Example 1
#   Input: $S = 'ababc'
#   Output: 'abb#c'
#   Pass 1: 'a', the FNR character is 'a'
#   Pass 2: 'ab', the FNR character is 'b'
#   Pass 3: 'aba', the FNR character is 'b'
#   Pass 4: 'abab', no FNR found, hence '#'
#   Pass 5: 'ababc' the FNR character is 'c'
# 
# Example 2
#   Input: $S = 'xyzzyx'
#   Output: 'xyzyx#'
#   Pass 1: 'x', the FNR character is 'x'
#   Pass 2: 'xy', the FNR character is 'y'
#   Pass 3: 'xyz', the FNR character is 'z'
#   Pass 4: 'xyzz', the FNR character is 'y'
#   Pass 5: 'xyzzy', the FNR character is 'x'
#   Pass 6: 'xyzzyx', no FNR found, hence '#'
# "
# 
# My notes: why is the FNR of "ab" (in pass 2) 'b' rather than 'a'?  Last non-repeating
# character would be more like it.  Basically: in each pass, take substr(1,len PASS) and then
# remove each LAST char if it's duplicated earlier in the substring, otherwise that's the FNR.
# If the string is empty, no FNR, print #.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;

#
# my $result = fnrpass($s);
#	Given a substring $s, perform one FNR pass and return a single
#	character - the last-most non-repeating character in $sub, or '#' if
#	all chars in $s repeat.
#
fun fnrpass( $s )
{
	my @list = split( //, $s );

	# convert each char of $s to bag (frequency hash) - same code was in ch-1!
	my %freq;
	$freq{$_}++ foreach @list;

	foreach my $ch (reverse @list)
	{
		return $ch if $freq{$ch}==1;
	}
	return '#';
}


#
# my $fnr = fnr($string);
#	Find the First (Last) Non-repeating char string,
#	as described above.
#
fun fnr( $string )
{
	my $len = length($string);
	my $result = '';
	foreach my $i (1..$len)
	{
		my $sub = substr($string,0,$i);	# take first $i chars
		$result .= fnrpass($sub);
	}
	return $result;
}



die "Usage: first(last)-non-repeating-char string\n" unless @ARGV==1;
my $string = shift;

my $fnr = fnr($string);
say "fnr: ", $fnr;
