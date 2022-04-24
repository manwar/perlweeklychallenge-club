#!/usr/bin/raku

sub factorize(Int $n, @primeFactors) {
    if $n < 2 {
        return;
    }

    my $i = 0;
    my @primes = (1 .. ∞).grep({ .is-prime });
    my $p = @primes[$i];

    while $p <= $n {

        if $n %% $p {
            @primeFactors.push($p);
            factorize($n div $p, @primeFactors);
            return;
        }
        $p = @primes[$i++];
    }
}

sub MAIN (
    Int $n #= a positive integer
) {
    my @factors;

    factorize($n, @factors);

    if (@factors.categorize({ $_ })).values.any > 1 {
        say 0;
    } else {
        say (@factors.elems % 2) ?? -1 !! 1;
    }
}
