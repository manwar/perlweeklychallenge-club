#!/usr/bin/perl

# Challenge 209
#
# Task 1: Special Bit Characters
# Submitted by: Mohammad S Anwar
#
# You are given an array of binary bits that ends with 0.
#
# Valid sequences in the bit string are:
#
# [0] -decodes-to-> "a"
# [1, 0] -> "b"
# [1, 1] -> "c"
#
# Write a script to print 1 if the last character is an “a” otherwise print 0.
# Example 1
#
# Input: @bits = (1, 0, 0)
# Output: 1
#
# The given array bits can be decoded as 2-bits character (10) followed by
# 1-bit character (0).
#
# Example 2
#
# Input: @bits = (1, 1, 1, 0)
# Output: 0
#
# Possible decode can be 2-bits character (11) followed by 2-bits character
# (10) i.e. the last character is not 1-bit character.

use Modern::Perl;

sub decode {
    my($in) = @_;
    my $out = "";
    for ($in) {
        while ($_ ne '') {
            if    (s/^0//)  { $out .= "a"; }
            elsif (s/^10//) { $out .= "b"; }
            elsif (s/^11//) { $out .= "c"; }
            else { die "invalid coded input: $in\n"; }
        }
    }
    return $out;
}

@ARGV==1 or die "usage: ch-1.pl bits\n";
my $in = shift;
my $out = decode($in);
say $out =~ /a$/ ? 1 : 0;
