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

sub isSmith($n) {
    my @digits = $n.comb;

    my @primeFactors;
    factorize($n, @primeFactors);
    if @primeFactors.elems < 2 {
        return;
    }

    @primeFactors = @primeFactors.map({ [+] $_.comb; });

    if ([+] @digits) == ([+] @primeFactors) {
        take $n;
    }
}

sub MAIN() {
    my @smiths = lazy gather {
        for 1 .. * -> $n {
            isSmith($n)
        }
    }

    @smiths[^10].join(', ').say;
}