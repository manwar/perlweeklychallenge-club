#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 081 Task #2 > Frequency Sort
#=============================================================================
# You are given file named input.
# Write a script to find the frequency of all the words.
# It should print the result as first column of each line should be the
# frequency of the the word followed by all the words of that frequency
# arranged in lexicographical order. Also sort the words in the ascending
# order of frequency.
# For the sake of this task, please ignore the following in the input file:
#   . " ( ) , 's --
# Keep hyphenated words and contractions, but reduce possessives to their base
# (e.g., "award-winning" and "doesn't" are words, but "Joe's" becomes "Joe"

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use File::Slurper qw/ read_text /;


sub Usage { "Usage: $0 filename" };

my $InFile = shift;

# It would be friendlier to allow stdin, but the spec says use a file.
die Usage() unless $InFile;

# Slurp input file into one long string.
my $input = read_text($InFile);

# Split on word separators, and convienently get rid of them.
# That might leave some empty strings, so filter those.
my @words = grep !/^$/, split(/\s|[\n\r."(),]/, $input);

# These next two cleanups could be chained to make one pass,
# but let's keep it readable for now.
#
# Phrases separated by long dashes turn into multiple words.
@words = map { if (/--/) { split(/--/) } else { $_ } } @words;

# Possessives reduce to the base noun.
@words = map { s/'s//; $_ } @words;

my %counts;
$counts{$_}++ foreach @words;

# Invert the hash to have counts as keys to lists of words.
my %countList;
for my $word ( keys %counts )
{
    push @{$countList{ $counts{$word} }}, $word;
}

# Numeric sort ascending on the counts.
for my $n ( sort { $a <=> $b } keys %countList )
{
    say "$n\t", join " ", sort @{$countList{$n}}
}

