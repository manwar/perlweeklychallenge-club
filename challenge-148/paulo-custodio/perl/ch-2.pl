#!/usr/bin/env perl

# Challenge 148
#
# TASK #2 › Cardano Triplets
# Submitted by: Mohammad S Anwar
# Write a script to generate first 5 Cardano Triplets.
#
# A triplet of positive integers (a,b,c) is called a Cardano Triplet if it
# satisfies the below condition.
#
# Cardano Triplets
#
# Example
# (2,1,5) is the first Cardano Triplets.

use Modern::Perl;

my $limit = 100;
my @triplets = cardano_triplets(5);
for (0..4) {
    say "(", join(",", @{$triplets[$_]}), ")";
}


sub cardano_triplets {
    my($n) = @_;

    my @found;
    for my $a (1..$limit) {
        for my $b (1..$limit) {
            for my $c (1..$limit) {
                if (8*($a**3)+15*($a**2)+6*$a-27*($b**2)*$c==1) {
                    push @found, [$a, $b, $c];
                }
            }
        }
    }

    return @found;
}
