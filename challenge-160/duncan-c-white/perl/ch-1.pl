#!/usr/bin/perl
# 
# TASK #1 - Four Is Magic
# 
# You are given a positive number, $n < 10.
# 
# Write a script to generate english text sequence starting with the English
# cardinal representation of the given number, the word 'is' and then
# the English cardinal representation of the count of characters that made
# up the first word, followed by a comma. Continue until you reach four.
# 
# Example 1:
# 
# 	Input: $n = 5
# 	Output: Five is four, four is magic.
# 
# Example 2:
# 
# 	Input: $n = 7
# 	Output: Seven is five, five is four, four is magic.
# 
# Example 3:
# 
# 	Input: $n = 6
# 	Output: Six is three, three is five, five is four, four is magic.
# 
# MY NOTES: ok.  Pretty easy.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util qw(sum0);
#use Data::Dumper;

my $debug=0;
die "Usage: four-is-magic [--debug] [N] (default 3, less then 10)\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;

my $n = shift // 3;
die "four-is-magic: n ($n) must be < 10\n" if $n>9;
die "four-is-magic: n ($n) must be >= 0\n" if $n<0;

my @n_to_word = qw(zero one two three four five six seven eight nine);

my $word = $n_to_word[$n];

my @answer = ();

while( $word ne "four" )
{
	my $len = length($word);
	my $lenword = $n_to_word[$len];
	push @answer, "$word is $lenword";
	say "debug: word=$word, len=$len, lenword=$lenword, added $word is $lenword" if $debug;
	$word = $lenword;
}

push @answer, "four is magic";

say join( ', ', @answer );
