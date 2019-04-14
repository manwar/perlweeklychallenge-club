#!/usr/bin/env perl6

use v6;

my @hamming = (1..∞).grep: { divisors($^num).grep( *.is-prime ).Set ⊆ (2,3,5).Set };
say "Hamming numbers [0..4]: " ~ @hamming[^5].join(", ");

sub divisors(Int:D $i -->Array[Int:D]) {
    if ($i == 0) { return 0; }

    my $sqrt = sqrt($i).Int;

    my Int:D @divs = grep { $i %% $^div }, 1..$sqrt;
    @divs.append: map { Int($i / $^div) }, @divs;

    return @divs;
}

