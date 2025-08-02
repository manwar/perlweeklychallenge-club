#!/usr/bin/env perl

# Task 2: Most Frequent Word
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a paragraph $p and a banned word $w.
# Write a script to return the most frequent word that is not banned.
# 
# Example 1
# Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
#        $w = "hit"
# Output: "ball"
# 
# The banned word "hit" occurs 3 times.
# The other word "ball" occurs 2 times.
# 
# Example 2
# Input: $p = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge."
#        $w = "the"
# Output: "Perl"
# 
# The banned word "the" occurs 3 times.
# The other word "Perl" occurs 2 times.

use strict;
use warnings;

my $paragraph = "Joe hit a ball, the hit ball flew far after it was hit.";
my $banned = "hit";
banned_word($paragraph, $banned);


$paragraph = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.";
$banned = "the";
banned_word($paragraph, $banned);

exit 0;

sub banned_word {
    my $paragraph = shift;
    my $banned = shift;

    $paragraph =~ s/[^[:word:] ]//g;

    my %freq;
    foreach my $word (split / /, $paragraph) {
        $freq{$word}++
            unless $word eq $banned;
    }

    printf "%s | %s -> %s\n",
        $paragraph, $banned, [ sort { $freq{$b} <=> $freq{$a} }
                               keys %freq
                             ]->[0];
    return undef;
}
