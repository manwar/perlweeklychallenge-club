#!/usr/bin/env raku

#`{
Task 1: Perrin Prime - Calculate the first 13 Perrin Primes.

The Perrin sequence is defined to start with [3, 0, 2];
    after that, term N is the sum of terms N-2 and N-3.
    (So it continues 3, 2, 5, 5, 7, ….)
A Perrin prime is a number in the Perrin sequence which is also a prime number.

EXAMPLE
f(13) = [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977]
}

sub MAIN(Int $n) {
    say "f($n) = ", pp($n);
}

sub pp(Int $n) {
    my @seed = <3 0 2>;
    my %pp;
    for 1 .. * -> $i {
        my $ppn = @seed[*-3] + @seed[*-2];
        @seed.push($ppn);
        %pp{$ppn} = 1 if $ppn.is-prime;
        last if %pp.elems == $n;
    }
    my @pp = %pp.keys.map({.Int}).sort;
}

