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

multi sub MAIN(Int $n where { $_ > 3}) {
    my @primeFactors;
    if $n.is-prime {
        @primeFactors.push($n);
    } else {
        factorize($n, @primeFactors);
    }

    @primeFactors.join(q{, }).say;
}
