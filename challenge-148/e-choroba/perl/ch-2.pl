#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

# https://stackoverflow.com/a/70414782/1030675
sub cardano_triplets {
    my ($count) = @_;
    for (my $u = 1; $count--; $u += 2) {
        my $A = (1 + 3 * $u) / 2;
        my $t = $u * $u * $u + $A * $A;

        my $B = int sqrt $t;
        --$B while $t % ($B * $B);

        my $C = $t / ($B * $B);

        say "$A $B $C";
    }
}

# This finds all the triplets, but they aren't sorted so nicely.
sub cardano_triplets_all {
    my ($count) = @_;
    for (my $u = 1;; $u += 2) {
        my $A = (1 + 3 * $u) / 2;
        my $t = $u * $u * $u + $A * $A;

        my $B = int sqrt $t;
        while (1) {
            --$B while $B && $t % ($B * $B);
            last unless $B;

            my $C = $t / ($B * $B);
            say "$A $B $C";
            return unless --$count;

            --$B;
        }
    }
}

cardano_triplets(5);
say '-' x 10;
cardano_triplets_all(5);
