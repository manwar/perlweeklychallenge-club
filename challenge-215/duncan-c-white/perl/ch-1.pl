#!/usr/bin/perl
# 
# Task 1: Odd one Out
# 
# You are given a list of words (alphabetic characters only) of same size.
# Write a script to remove all words not sorted alphabetically and print
# the number of words in the list that are not alphabetically sorted.
# 
# Example 1
# 
#   Input: @words = ('abc', 'xyz', 'tsu')
#   Output: 1
# 
#   The words 'abc' and 'xyz' are sorted and can't be removed.
#   The word 'tsu' is not sorted and hence can be removed.
# 
# Example 2
# 
#   Input: @words = ('rat', 'cab', 'dad')
#   Output: 3
# 
#   None of the words in the given list are sorted.
#   Therefore all three needs to be removed.
# 
# Example 3
# 
#   Input: @words = ('x', 'y', 'z')
#   Output: 0
# 
# MY NOTES: strangely worded, all the stuff about removing words you don't want
# and then counting what's left (but not displaying what's left) can be
# simplified to: count what you want (the non-sorted words), and that's easy.
# But on second thought, let's remove the words anyway, even if we only print
# them out in debug mode.
# 
# GUEST LANGUAGE: As a bonus, I've had a go at translating ch-1.pl into C,
# look in the C/ directory for that.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: odd-one-out [--debug] wordlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @list = split( /,/, join(',',@ARGV) );

say "debug: list: ", join(',',@list) if $debug;

#
# my $issorted = sortedletters( $word );
#	Return true iff the letters of $word are sorted.
#
sub sortedletters
{
	my( $word ) = @_;
	my @let = split( //, $word );
	foreach my $pos (0..$#let-1)
	{
		return 0 if $let[$pos] gt $let[$pos+1];
	}
	return 1;
}


my @sorted = grep { sortedletters($_) } @list;
my $removed = @list - @sorted;
say $removed;
if( $debug )
{
	say "list (of sorted) words is: ", join(',',@sorted);
	my @notsorted = grep { ! sortedletters($_) } @list;
	say "unsorted words removed are: ", join(',',@notsorted);
}
