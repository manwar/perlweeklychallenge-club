#!/usr/bin/perl6

multi sub MAIN(
    Int $M,     #= dividend
    Int $N      #= divisor
) {
    my $negative = ($M < 0 ^^ $N < 0);
    my $dividend = abs($M);
    my $divisor = abs($N);
    my $quotient = 0;

    while $dividend >= $divisor {
        $dividend -= $divisor;
        $quotient++;
    }

    if $negative {
        $quotient = -$quotient;
        if $dividend > 0 {
            $quotient--;
        }
    }

    say $quotient;
}