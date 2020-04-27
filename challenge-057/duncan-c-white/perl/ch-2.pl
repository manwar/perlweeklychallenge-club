#!/usr/bin/perl
# 
# Task 2: "Shortest Unique Prefix
# 
# Write a script to find the shortest unique prefix for each word in
# the given list. The prefixes will not necessarily be of the same length.
#
# Sample Input
# 
#  [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ]
# 
# Expected Output
# 
#  [ "alph", "b", "car", "cadm", "cade", "alpi" ]
# "
# 
# My notes: sounds entirely straightforward.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;


die "Usage: shortest-unique-prefix WORD_LIST\n" if @ARGV==0;
my @list = @ARGV;

my @uniqprefix;

foreach my $word (@list)
{
	my @otherwords = grep { $_ ne $word } @list;

	my $uniqprefix = find_shortest_unique_prefix( $word, @otherwords );
	push @uniqprefix, $uniqprefix;
}

say $_ for @uniqprefix;


#
# my $uniqprefix = find_shortest_unique_prefix( $word, @otherwords );
#	Given a word $word, and a list of otherwords @otherwords,
#	find and return the shortest prefix of $word that is unique in all the other
#	words.
#
fun find_shortest_unique_prefix( $word, @otherwords )
{
	my $len = length($word);
	# try gradually lengthening possible prefixes
	foreach my $prefixlen (1..$len)
	{
		my $prefix = substr($word,0,$prefixlen);
		my @clashing = grep { substr($_,0,$prefixlen) eq $prefix } @otherwords;
		return $prefix unless @clashing;
	}
	return $word;
}
