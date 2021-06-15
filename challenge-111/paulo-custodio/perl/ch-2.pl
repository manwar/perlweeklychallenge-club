#!/usr/bin/env perl

# Challenge 111
#
# TASK #2 - Ordered Letters
# Submitted by: E. Choroba
# Given a word, you can sort its letters alphabetically (case insensitive).
# For example, “beekeeper” becomes “beeeeekpr” and “dictionary” becomes
# “acdiinorty”.
#
# Write a script to find the longest English words that don’t change when
# their letters are sorted.

use Modern::Perl;

my @words;
my $max_len = 0;
while (<>) {
    chomp;
    my $word = lc($_);
    my $drow = join '', (sort split //, $word);
    if ($word eq $drow) {
        $max_len = length($word) if $max_len < length($word);
        push @words, $word;
    }
}
say join "\n", grep {length($_)==$max_len} @words;
