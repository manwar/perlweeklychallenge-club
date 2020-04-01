#!/usr/bin/perl6

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

sub MAIN() {
    for 1 .. 50 -> $n {
        my @primeFactors;
        if $n.is-prime {
            push @primeFactors, $n;
        } else {
            factorize($n, @primeFactors);
        }

        if @primeFactors.elems.is-prime {
            say $n;
        }
    }
}