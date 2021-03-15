#!/usr/bin/perl

# Challenge 097
#
# TASK #2 › Binary Substings
# Submitted by: Mohammad S Anwar
# You are given a binary string $B and an integer $S.
#
# Write a script to split the binary string $B of size $S and then find the
# minimum number of flips required to make it all the same.
#
# Example 1:
# Input: $B = “101100101”, $S = 3
# Output: 1
#
# Binary Substrings:
#     "101": 0 flip
#     "100": 1 flip to make it "101"
#     "101": 0 flip
# Example 2:
# Input $B = “10110111”, $S = 4
# Output: 2
#
# Binary Substrings:
#     "1011": 0 flip
#     "0111": 2 flips to make it "1011"

use strict;
use warnings;
use 5.030;

@ARGV==2 && $ARGV[0]=~/^[01]+$/ && $ARGV[1]=~/^\d+$/
&& length($ARGV[0])%$ARGV[1]==0
    or die "Usage: ch-2.pl BITS N\n";
say bit_flips(@ARGV);

sub bit_flips {
    my($bits, $n) = @_;
    my $re = "." x $n;
    my @bits = grep {$_ ne ''} split /($re)/, $bits;

    my $flips = 0;
    my $b0 = shift @bits;                       # initial value
    $flips += str_flips($b0, $_) for @bits;     # flips to initial value

    return $flips;
}

sub str_flips {
    my($a, $b) = @_;
    my @a = split //, $a;
    my @b = split //, $b;
    my $flips = grep {$a[$_] ne $b[$_]} 0..$#a;
    return $flips;
}
