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

sub isUgly(Int $n) {
    my @primeFactors;
    factorize($n, @primeFactors);
    return @primeFactors.grep({ $_ != 2 && $_ != 3 &&  $_ != 5 }).elems == 0;
}

sub MAIN(
    Int $n where { $n >= 1; } #= integer greater than 0
) {
    my $number = 1;
    my $uglies = 0;

    loop {
        if isUgly($number) {
            $uglies++;
        }

        if $uglies >= $n {
            say $number;
            last;
        }

        $number++;
    }
}