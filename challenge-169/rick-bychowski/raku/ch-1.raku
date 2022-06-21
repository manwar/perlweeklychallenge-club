#!/usr/bin/env raku

#Brilliant Numbers
sub MAIN($n = 20) {
    my @brilliant;
    for 2 .. * -> $i {
        @brilliant.push($i) if is-brilliant($i);
        last if @brilliant.elems == $n
    }
    say @brilliant.join(", ");
}

sub is-brilliant($dividend) {
    for 2 ..^ $dividend -> $divisor {
        if $dividend %% $divisor {
            my $quotient = $dividend/$divisor;
            my $l= log10($divisor).truncate;
            if $quotient.is-prime and $l == log10($quotient).truncate {
                return True;
            } else {
                return False;
            }
        }
    }
}

=begin comment
Write a script to generate first 20 Brilliant Numbers.
Brilliant numbers are numbers with two prime factors of the same length.
The number should have exactly two prime factors, i.e. it’s the product of two
    primes of the same length.

For example,
24287 = 149 x 163
24289 = 107 x 227

Therefore 24287 and 24289 are 2-brilliant numbers.
These two brilliant numbers happen to be consecutive as there are no even
    brilliant numbers greater than 14.

Output
4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209, 221, 247, 253, 289, 299

=end comment
