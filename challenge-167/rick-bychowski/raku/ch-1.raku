#!/usr/bin/env raku

# Write a script to find out first 10 circular primes having at least 3 digits (base 10).
# https://en.wikipedia.org/wiki/Circular_prime
# A circular prime with at least two digits can only consist of combinations of the digits 1, 3, 7 or 9

sub MAIN(:$find = 10) {
    my @circular-primes;
    for 113 .. * -> Int $n {
        next if $n ~~ <[0 2 4 6 8]>;
        next unless $n.is-prime;
        @circular-primes.push: $n if is-circ-prime($n);
        last if @circular-primes.elems == $find;
    }
    
    say @circular-primes.join(", ");

    sub is-circ-prime( $n ) {
        my @comb = $n.comb;
        for 1 ..^ @comb -> $i {
            my $perm = @comb.rotate($i).join;
            return False unless $perm > $n and $perm.is-prime;
        }
        True;
    }
}
