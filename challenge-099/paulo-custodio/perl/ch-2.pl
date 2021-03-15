#!/usr/bin/perl

# Challenge 099
#
# TASK #2 › Unique Subsequence
# Submitted by: Mohammad S Anwar
# You are given two strings $S and $T.
#
# Write a script to find out count of different unique subsequences matching
# $T without changing the position of characters.
#
# Example 1:
# Input: $S = "littleit', $T = 'lit'
# Output: 5
#
#     1: [lit] tleit
#     2: [li] t [t] leit
#     3: [li] ttlei [t]
#     4: litt [l] e [it]
#     5: [l] ittle [it]
# Example 2:
# Input: $S = "london', $T = 'lon'
# Output: 3
#
#     1: [lon] don
#     2: [lo] ndo [n]
#     3: [l] ond [on]

use strict;
use warnings;
use 5.030;

@ARGV==2 or die "Usage: ch-1.pl STRING TEST\n";
say count_subsequences(@ARGV);


sub count_subsequences {
    my($s, $t) = @_;
    my $count = 0;
    my @s = split(//, $s);
    my @t = split(//, $t);
    count_subsequences_sub(\@s, \@t, \$count);
    return $count;
}

sub count_subsequences_sub {
    my($s, $t, $count) = @_;
    my @s = @$s;
    my @t = @$t;

    if (!@t) {
        $$count++;
    }
    elsif (!@s) {
    }
    elsif ($s[0] eq $t[0]) {    # this char matches
        count_subsequences_sub([@s[1..$#s]], [@t[1..$#t]], $count);
        count_subsequences_sub([@s[1..$#s]], [@t], $count);
    }
    else {
        count_subsequences_sub([@s[1..$#s]], [@t], $count);
    }
}
