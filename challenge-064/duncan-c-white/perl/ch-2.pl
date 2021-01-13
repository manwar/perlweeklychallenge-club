#!/usr/bin/perl
#
# Task 2: "Word Break
#
# You are given a string $S and an array of words @W.
# 
# Write a script to find out if $S can be split into sequence of one
# or more words as in the given @W.  Print all the words if found
# otherwise print 0.
# 
# Example 1:
# 
# Input:
# 
# $S = "perlweeklychallenge"
# @W = ("weekly", "challenge", "perl")
# 
# Output:
# 
# "perl", "weekly", "challenge"
# 
# Example 2:
# 
# Input:
# 
# $S = "perlandraku"
# @W = ("python", "ruby", "haskell")
# 
# Output:
# 
# 0 as none matching word found.
# "
# 
# My notes: sounds like fun.  Nice question.  Input format:
# string and one or more words on command line.  So:
# ./ch-2.pl perlweeklychallenge weekly challenge perl
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;

die "Usage: word-break string word+\n" unless @ARGV>2;
my $string = shift;
my @w = @ARGV;

my( $ok, @sol ) = search( $string, @w );
say $ok ? join(' ',@sol) : "0";

#
# my( $ok, @sol ) = search( $string, @w );
#	Search for ways of combining words in @w to make $string,
#	using each word in @w only once.  Return (1, solutionwords)
#	if there is a way, or (0) if there is no way.
#
fun search( $string, @w )
{
	#say "searching for $string in ", join(',',@w);
	return ( 1 ) if $string eq "" && @w == 0;
	my @first = grep { $string =~ /^$_/ } @w;

	foreach my $w (@first)
	{
		my $s = $string;
		$s =~ s/^$w//;
		my @restw = grep { $_ ne $w } @w;
		my( $ok, @sol ) = search( $s, @restw );
		return (1, $w, @sol) if $ok;
	}
	return ( 0 );
}
