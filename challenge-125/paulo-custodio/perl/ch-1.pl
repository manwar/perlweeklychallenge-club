#!/usr/bin/env perl

# Challenge 125
#
# TASK #1 > Pythagorean Triples
# Submitted by: Cheok-Yin Fung
# You are given a positive integer $N.
#
# Write a script to print all Pythagorean Triples containing $N as a member.
# Print -1 if it can't be a member of any.
#
# Triples with the same set of elements are considered the same, i.e. if your
# script has already printed (3, 4, 5), (4, 3, 5) should not be printed.
#
# The famous Pythagorean theorem states that in a right angle triangle, the
# length of the two shorter sides and the length of the longest side are
# related by a2+b2 = c2.
#
# A Pythagorean triple refers to the triple of three integers whose lengths can
# compose a right-angled triangle.
#
# Example
#     Input: $N = 5
#     Output:
#         (3, 4, 5)
#         (5, 12, 13)
#
#     Input: $N = 13
#     Output:
#         (5, 12, 13)
#         (13, 84, 85)
#
#     Input: $N = 1
#     Output:
#         -1

use Modern::Perl;
use ntheory 'gcd';
use constant MAX_GEN => 100;

sub gen_pythagorean_triples {
    my @out;
    my %seen;
    for my $m (2 .. MAX_GEN) {
        for my $n (1 .. $m-1) {
            if (gcd($m, $n)==1) {
                my $a = $m*$m-$n*$n;
                my $b = 2*$m*$n;
                my $c = $m*$m+$n*$n;
                if ($m%2==1 && $n%2==1) {
                    $a = $a/2;
                    $b = $b/2;
                    $c = $c/2;
                }
                if ($a > $b) {
                    ($a, $b) = ($b, $a);
                }
                if (!$seen{$a}{$b}) {
                    push @out, [$a, $b, $c];
                    $seen{$a}{$b} = 1;
                }
            }
        }
    }
    return @out;
}

my @pythagorean_triples = gen_pythagorean_triples();
my $N = shift||0;
my @found = grep {$_->[0]==$N || $_->[1]==$N || $_->[2]==$N} @pythagorean_triples;
if (!@found) {
    say -1;
}
else {
    for (@found) {
        say "(", join(", ", @$_), ")";
    }
}
