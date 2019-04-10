#!/usr/bin/env perl6
use v6;

subset PositiveInt of Int where { $^n >= 0}

sub MAIN(PositiveInt $number = 5) {
    say get-hamming-sequence()[0..$number-1];
}

sub get-hamming-sequence() {
    return lazy gather { take $_ if is-hamming-number($_) for 1..Inf };
}

sub is-hamming-number(PositiveInt $number is copy --> Bool) {
    return True if $number == 1;

    for 2,3,5 -> $divisor {
        return is-hamming-number($number div $divisor) if $number %% $divisor;
    }

    return False;
};
