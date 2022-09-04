#!/usr/bin/perl
# 
# Task 1: First Unique Character
# 
# You are given a string, $s.
# Write a script to find out the first unique character in the given string
# and print its index (0-based).
# 
# Example 1
# 
# Input: $s = "Perl Weekly Challenge"
# Output: 0 as 'P' is the first unique character
# 
# Example 2
# 
# Input: $s = "Long Live Perl"
# Output: 1 as 'o' is the first unique character
# 
# MY NOTES: ok, sounds extremely easy, first pass: build a freq hash (a bag),
# second pass: sequence through the string, print index of the first char
# with freq 1.  There is one case where the behaviour is undefined: what if
# there are no unique characters in the string? I've decided to produce pos -1
# in that case.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: fuc [--debug] Str\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $s = shift;

#
# my $pos = fuc_pos( $s );
#	Find the position of the first unique character in $s,
#	or -1 if all characters in $s are repeated.
#
sub fuc_pos
{
	my( $s ) = @_;

	my %freq;
	foreach my $ch (split(//,$s))
	{
		$freq{$ch}++;
	}
	foreach my $pos (0..length($s)-1)
	{
		if( $freq{substr($s,$pos,1)} == 1 )
		{
			return $pos;
		}
	}
	return -1;
}

my $pos = fuc_pos( $s );
say $pos;
