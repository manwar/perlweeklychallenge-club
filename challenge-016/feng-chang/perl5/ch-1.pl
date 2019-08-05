#!/bin/env perl

use Modern::Perl;

my $pie = 1.0;
my $max = 0.0;
my $max_index = 0;
my @share = (0);

for my $i (1..100) {
    $share[$i] = $pie * $i / 100.0;
    $pie -= $share[$i];

    if ($share[$i] > $max) {
        $max = $share[$i];
        $max_index = $i;
    }

    last if $pie < $max;
}

say "index $max_index is largest: $max";
