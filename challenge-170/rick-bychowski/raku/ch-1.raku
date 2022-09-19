#!/usr/bin/env raku

sub MAIN(Int $n = 9){
    my @primes;
    @primes[^$n] = (1 .. *).map({ $_ if $_.is-prime});
    for 0 .. $n -> $i {
        my @p = @primes[^$i];
        @p.unshift(1);
        my $product = [*] @p;
        my $factors = @p.join("x");
        printf("P(%d) = %-10d  (%s)\n", $i, $product, $factors);
    }
}

=begin comment
Task 1: Primorial Numbers
Submitted by: Mohammad S Anwar

Write a script to generate first 10 Primorial Numbers.
Primorial numbers are those formed by multiplying successive prime numbers.

P(0) = 1           (1)
P(1) = 2           (1x2)
P(2) = 6           (1x2x3)
P(3) = 30          (1x2x3x5)
P(4) = 210         (1x2x3x5x7)
P(5) = 2310        (1x2x3x5x7x11)
P(6) = 30030       (1x2x3x5x7x11x13)
P(7) = 510510      (1x2x3x5x7x11x13x17)
P(8) = 9699690     (1x2x3x5x7x11x13x17x19)
P(9) = 223092870   (1x2x3x5x7x11x13x17x19x23)
=end comment
