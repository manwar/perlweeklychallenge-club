#!/usr/bin/env perl

# Task 1: Broken Keys
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a sentence, $sentence and list of broken keys @keys.
# Write a script to find out how many words can be typed fully.
#
# Example 1
# Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
# Output: 0
# 
# Example 2
# Input: $sentence = "Perl and Raku", @keys = ('a')
# Output: 1
# 
# Only Perl since the other word two words contain 'a' and can't be typed fully.
# 
# Example 3
# Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
# Output: 2
# 
# Example 4
# Input: $sentence = "The joys of polyglottism", @keys = ('T')
# Output: 2

use strict;
use warnings;
use List::Util qw/ sum /;

my $sentence = "Perl Weekly Challenge";
my @keys = ('l', 'a');
broken_keys($sentence, \@keys);

$sentence = "Perl and Raku";
@keys = ('a');
broken_keys($sentence, \@keys);

$sentence = "Well done Team PWC";
@keys = ('l', 'o');
broken_keys($sentence, \@keys);

$sentence = "The joys of polyglottism";
@keys = ('T');
broken_keys($sentence, \@keys);

exit 0;

sub broken_keys {
    my $sentence = shift;
    my $keys = shift;

    printf "sentence '%s' keys (%s) -> %d\n",
        $sentence,
        (join ',', @keys), 
        (scalar split / /, $sentence) -
         sum map {
               my $tot = 0;
               my $word = lc($_);
               $tot += 1 if sum map { $_ = lc($_);
                                      $word =~ /$_/ ? 1 : 0 
                                    } @keys;
             } split / /, lc($sentence);
}
