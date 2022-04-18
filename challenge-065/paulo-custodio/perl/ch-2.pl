#!/usr/bin/env perl

# Challenge 065
#
# TASK #2 › Palindrome Partition
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
#
# You are given a string $S. Write a script print all possible partitions that
# gives Palindrome. Return -1 if none found.
#
# Please make sure, partition should not overlap. For example, for given string
# “abaab”, the partition “aba” and “baab” would not be valid, since they overlap.
#
# Example 1
# Input: $S = 'aabaab'
# Ouput:
#  There are 3 possible solutions.
#  a) 'aabaa'
#  b) 'aa', 'baab'
#  c) 'aba'
# Example 2
# Input: $S = 'abbaba'
# Output:
#  There are 3 possible solutions.
#  a) 'abba'
#  b) 'bb', 'aba'
#  c) 'bab'

use Modern::Perl;

partitions(shift||"");


sub is_palindrome {
    my($s) = @_;
    return length($s) >= 2 && $s eq reverse($s);
}

sub partitions {
    my($s) = @_;
    my %seen;
    my $len = length($s);
    for my $lead (0 .. $len) {
        for my $p1 (2 .. $len) {
            for my $p2 (0, 2 .. $len) {
                for my $tail (0 .. $len) {
                    next unless $lead+$p1+$p2+$tail==$len;
                    my $s1 = substr($s, $lead, $p1);
                    my $s2 = substr($s, $lead+$p1, $p2);
                    if (is_palindrome($s1) && is_palindrome($s2)) {
                        if (!$seen{"$s1, $s2"}++) {
                            say "$s1, $s2";
                        }
                    }
                    elsif (is_palindrome($s1)) {
                        if (!$seen{$s1}++) {
                            say $s1;
                        }
                    }
                }
            }
        }
    }
}
