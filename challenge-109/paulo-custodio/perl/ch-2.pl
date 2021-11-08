#!/usr/bin/env perl

# Challenge 109
#
# TASK #2 - Four Squares Puzzle
# Submitted by: Mohammad S Anwar
# You are given four squares as below with numbers named a,b,c,d,e,f,g.
#
#               (1)                    (3)
#         ╔══════════════╗      ╔══════════════╗
#         ║              ║      ║              ║
#         ║      a       ║      ║      e       ║
#         ║              ║ (2)  ║              ║  (4)
#         ║          ┌───╫──────╫───┐      ┌───╫─────────┐
#         ║          │   ║      ║   │      │   ║         │
#         ║          │ b ║      ║ d │      │ f ║         │
#         ║          │   ║      ║   │      │   ║         │
#         ║          │   ║      ║   │      │   ║         │
#         ╚══════════╪═══╝      ╚═══╪══════╪═══╝         │
#                    │       c      │      │      g      │
#                    │              │      │             │
#                    │              │      │             │
#                    └──────────────┘      └─────────────┘
# Write a script to place the given unique numbers in the square box so that sum
# of numbers in each box is the same.
#
# Example
# Input: 1,2,3,4,5,6,7
#
# Output:
#
#     a = 6
#     b = 4
#     c = 1
#     d = 5
#     e = 2
#     f = 3
#     g = 7
#
#     Box 1: a + b = 6 + 4 = 10
#     Box 2: b + c + d = 4 + 1 + 5 = 10
#     Box 3: d + e + f = 5 + 2 + 3 = 10
#     Box 4: f + g = 3 + 7 = 10

use Modern::Perl;
use Math::Combinatorics;

@ARGV==7 or die "Usage: ch-2.pl Nx7\n";
my @result = place_numbers(@ARGV);
for my $i (0..6) {
    say chr(ord('a')+$i)," = ",$result[$i];
}

# Note: return first solution found, not necessarily same as example
sub place_numbers {
    my(@n) = @_;
    my $combinat = Math::Combinatorics->new(count => 7, data => \@n);
    while(my @permut = $combinat->next_permutation) {
        my($a,$b,$c,$d,$e,$f,$g) = @permut;
        my $sum = $a + $b;
        return @permut if $b + $c + $d == $sum &&
                          $d + $e + $f == $sum &&
                          $f + $g == $sum;
    }
}
