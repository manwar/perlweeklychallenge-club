#!/usr/bin/raku

sub MAIN() {
    my @primes;
    my $n = 2;

    while @primes.elems < 20 {
        if !$n.match( /0/ ) && $n.is-prime() {
            my $candidate = $n;

            while $candidate.is-prime() {
                $candidate = $candidate.substr(1,);
            }

            if $candidate.chars == 0 {
                @primes.push($n);
            }
        }
        $n++;
    }

    @primes.join(q{, }).say;
}