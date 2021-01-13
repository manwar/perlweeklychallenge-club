#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #2 › FNR Character
# Submitted by: Mohammad S Anwar
#
# You are given a string $S.
#
# Write a script to print the series of first non-repeating character
# (left -> right) for the given string. Print # if none found.
#
# Example 1
# Input: $S = ‘ababc’
# Output: ‘abb#c’
# Pass 1: “a”, the FNR character is ‘a’
# Pass 2: “ab”, the FNR character is ‘b’
# Pass 3: “aba”, the FNR character is ‘b’
# Pass 4: “abab”, no FNR found, hence ‘#’
# Pass 5: “ababc” the FNR character is ‘c’
#
# Example 2
# Input: $S = ‘xyzzyx’
# Output: ‘xyzyx#’
# Pass 1: “x”, the FNR character is “x”
# Pass 2: “xy”, the FNR character is “y”
# Pass 3: “xyz”, the FNR character is “z”
# Pass 4: “xyzz”, the FNR character is “y”
# Pass 5: “xyzzy”, the FNR character is “x”
# Pass 6: “xyzzyx”, no FNR found, hence ‘#’

my $s = $ARGV[0];
my @c = split //, $s;
my %seen;
my @nr;
my $out;

for my $c (@c) {
    # have we seen $c before?
    unless (defined $seen{$c}) {
        # add $c to @nr
        $seen{$c} = 1;
        push @nr, $c;
    } else {
        # remove $c from @nr
        if ($seen{$c}) {
            for my $i (0..$#nr) {
                if ($nr[$i] eq $c) {
                    splice @nr, $i, 1;
                    last;
                }
            }
            $seen{$c} = 0;
        }
    }

    # now the FNR is either the last element of @nr, or #
    $out .= @nr ? $nr[-1] : '#';
}

say $out;
