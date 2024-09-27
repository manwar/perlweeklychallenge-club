#!/usr/bin/env perl

# Challenge 148
#
# TASK #2 > Cardano Triplets
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
use List::Util 'sum';

my @triplets = cardano_triplets(5);
for (@triplets) {
    say "(", join(",", @$_), ")";
}

sub cardano_triplets {
    my($num) = @_;

    my @triplets;
    my $K = 0;
    while (@triplets < $num*2) {        # we are not sure in which order they are generated
        my $A = 2+3*$K;
        my $T = ($K+1)**2 * (8*$K+5);
        my @divs = divisors($T);
        for my $div (@divs) {
            if (int(sqrt($div)) == sqrt($div)) {
                my $B = sqrt($div);
                my $C = $T / $B**2;
                push @triplets, [$A, $B, $C];
            }
        }
        @triplets = sort {sum(@$a) <=> sum(@$b)} @triplets;

        $K++;
    }

    return @triplets[0..$num-1];
}

sub divisors {
    my($n) = @_;
    my @divs1;
    my @divs2;
    for my $k (1 .. $n) {
        last if @divs2 && $k >= $divs2[0];
        if ($n % $k == 0) {
            push @divs1, $k;
            unshift @divs2, $n/$k;
        }
    }
    return (@divs1, @divs2);
}
