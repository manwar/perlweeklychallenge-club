#!/usr/bin/env perl

# Challenge 249
#
# Task 2: DI String Match
# Submitted by: Mohammad S Anwar
#
# You are given a string s, consisting of only the characters "D" and "I".
#
# Find a permutation of the integers [0 .. length(s)] such that for each character s[i] in the string:
#
# s[i] == 'I' ⇒ perm[i] < perm[i + 1]
# s[i] == 'D' ⇒ perm[i] > perm[i + 1]
#
#
# Example 1
#
# Input: $str = "IDID"
# Output: (0, 4, 1, 3, 2)
#
# Example 2
#
# Input: $str = "III"
# Output: (0, 1, 2, 3)
#
# Example 3
#
# Input: $str = "DDI"
# Output: (3, 2, 0, 1)

use Modern::Perl;
use Math::Combinatorics;

my @perm = find_permutation(@ARGV);
say "(", join(", ", @perm), ")";

sub find_permutation {
    my($s) = @_;
    my @s = split //, $s;
    my @n = (0 .. length($s));
    my $combinat = Math::Combinatorics->new(count => scalar(@n), data => \@n);
    my @permu;
    while (@permu = $combinat->next_permutation) {
        if (check_permu(\@s, \@permu)) {
            return @permu;
        }
    }
    return ();
}

sub check_permu {
    my($s, $permu) = @_;
    my @s = @$s;
    my @permu = @$permu;

    for my $i (0 .. $#permu-1) {
        if (!($s[$i] eq 'I' && $permu[$i] < $permu[$i+1] ||
              $s[$i] eq 'D' && $permu[$i] > $permu[$i+1])) {
            return 0;
        }
    }
    return 1;
}
