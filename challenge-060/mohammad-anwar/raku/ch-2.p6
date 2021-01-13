#!/usr/bin/env perl6

use v6.d;

sub MAIN(:@n where .all ~~ Int = <0 1 2 5>, Int :$x = 2, Int :$y = 21) {

    my @numbers = find-numbers(@n, $x, $y);
    say @numbers.join(", ");

}

sub find-numbers(@n, $x, $y) {

    my @numbers = ();
    for @n X @n -> @x {
        my $number = ([~] @x) + 0;
        next unless $number.chars == $x && $number < $y;
        @numbers.push: $number;
    }

    return @numbers;
}
