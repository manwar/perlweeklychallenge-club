#!/usr/bin/env perl

# Challenge 266
#
# Task 1: Uncommon Words
# Submitted by: Mohammad Sajid Anwar
#
# You are given two sentences, $line1 and $line2.
#
# Write a script to find all uncommmon words in any order in the given two
# sentences. Return ('') if none found.
#
#     A word is uncommon if it appears exactly once in one of the sentences
#     and doesn’t appear in other sentence.
#
# Example 1
#
# Input: $line1 = 'Mango is sweet'
#        $line2 = 'Mango is sour'
# Output: ('sweet', 'sour')
#
# Example 2
#
# Input: $line1 = 'Mango Mango'
#        $line2 = 'Orange'
# Output: ('Orange')
#
# Example 3
#
# Input: $line1 = 'Mango is Mango'
#        $line2 = 'Orange is Orange'
# Output: ('')

use Modern::Perl;

my($line1, $line2) = split /,/, "@ARGV";
my %count;
for my $word (split ' ', "$line1 $line2") {
    $count{$word}++;
}
my @uncommon = sort grep {$count{$_}==1} keys %count;

say @uncommon ? "@uncommon" : "''";
