#!/usr/bin/raku

sub nearestLowerPrimeDistance($sum) {
    my $candidate = $sum;

    while $candidate > 1 && !$candidate.is-prime {
        $candidate--;
    }

    return $sum - $candidate;
}

sub nearestUpperPrimeDistance($sum, $upperBound) {
    my $candidate = $sum;

    while $candidate <= $upperBound && !$candidate.is-prime {
        $candidate++;
    }

    return $candidate - $sum;
}

sub MAIN(
    $str
) {
    my $sum = $str.comb.map({ .ord }).sum;
    my $lower = nearestLowerPrimeDistance($sum);
    my $upper = nearestUpperPrimeDistance($sum, $sum + $lower);
    say ($lower, $upper).min;
}
