#!/usr/bin/perl
# 
# Task 1: Jumping Letters
# 
# You are given a word having alphabetic characters only, and a list of
# positive integers of the same length
# 
# Write a script to print the new word generated after jumping forward
# each letter in the given word by the integer in the list. The given list
# would have exactly the number as the total alphabets in the given word.
# 
# Example 1
# 
#   Input: $word = 'Perl' and @jump = (2,22,19,9)
#   Output: Raku
# 
#   'P' jumps 2 place forward and becomes 'R'.
#   'e' jumps 22 place forward and becomes 'a'.
#       (jump is cyclic i.e. after 'z' you go back to 'a')
#   'r' jumps 19 place forward and becomes 'k'.
#   'l' jumps 9 place forward and becomes 'u'.
# 
# Example 2
# 
#   Input: $word = 'Raku' and @jump = (24,4,7,17)
#   Output: 'Perl'
# 
# MY NOTES: sounds very easy.  Essentially ROT(n) for a different value of n for
# each letter.
# 
# GUEST LANGUAGE: As a bonus, I will have a go at translating ch-1.pl into C
# but I'll do that tomorrow.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(any);

my $debug=0;
die "Usage: jumping-letters [--debug] word intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>1;

my $word = shift;

my @list = split( /,/, join(',',@ARGV) );

say "debug: word: $word, list: ", join(',',@list) if $debug;

my $len = length($word);
my $llen = @list;

die "jumping-letters: word (len $len) must be same length as list ".
    "(len $llen)\n"
	unless $len == $llen;

foreach my $pos (0..$len-1)
{
	my $letter = substr($word,$pos,1);
	my $offset = $list[$pos];
	say "debug: pos: $pos, letter: $letter, offset: $offset" if $debug;
	my $base = 0;
	if( $letter =~ /^[a-z]/ )
	{
		$base = ord('a');
	} elsif( $letter =~ /^[A-Z]/ )
	{
		$base = ord('A');
	} else
	{
		next;
	}
	my $lpos = ord($letter)-$base;
	$offset = ($offset + $lpos) % 26;
	#$offset -= 26 while $offset > 25;
	#$offset += 26 while $offset < 0;
	say "debug: letter=$letter, base=$base, lpos=$lpos, offset=$offset"
		if $debug;
	$letter = chr($offset+$base);
	say "debug: newletter=$letter" if $debug;
	substr($word,$pos,1) = $letter;
}

say $word;
