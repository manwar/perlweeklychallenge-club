#!/usr/bin/perl
use warnings;
use strict;

sub pythagorean_triples {
    my ($n) = @_;
    my @solutions;
    my $nsquare = $n * $n;

    # A <= B < C

    # A**2 + n**2 = C**2
    for my $A (1 .. $n) {
        my $B = sqrt($nsquare - $A * $A);
        last if $B < $A;

        push @solutions, [$A, $B, $n]
            if $B == int $B;
    }

    # A**2 + n**2 = C**2
    for my $A (1 .. $n) {
        my $C = sqrt($A * $A + $nsquare);
        push @solutions, [$A, $n, $C]
            if $C == int $C;
    }

    # n**2 + B ** 2 = C**2
    my $B = $n;
    while (1) {
        my $C = sqrt($nsquare + $B * $B);
        last if $C - $B < 1;

        push @solutions, [$n, $B, $C]
            if $C == int $C;
    } continue {
        ++$B;
    }

    return @solutions ? \@solutions : -1
}

use Test2::V0;
plan 5;

is pythagorean_triples(5),
    bag { item [3, 4, 5];
          item [5, 12, 13];
          end },
    'Example 1';

is pythagorean_triples(13),
    bag { item [5, 12, 13];
          item [13, 84, 85];
          end },
    'Example 2';

is pythagorean_triples(1), -1, 'Example 3';

is pythagorean_triples(12),
    bag { item [ 5,  12,  13];
          item [ 9,  12,  15];
          item [12,  16,  20];
          item [12,  35,  37];
          end },
    'N=12';

is pythagorean_triples(40),
    bag { item [ 9,  40,  41];
          item [24,  32,  40];
          item [30,  40,  50];
          item [40,  42,  58];
          item [40,  75,  85];
          item [40,  96, 104];
          item [40, 198, 202];
          item [40, 399, 401];
          end },
    'N=40';
