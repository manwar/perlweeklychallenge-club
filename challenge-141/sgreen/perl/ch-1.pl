#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _divisors {
    my $number = shift;

    # One only has one divisor
    return 1 if $number == 1;

    # All other numbers have 1 and itself as divisors
    my $divisors = 2;

    # Find other divisors
    foreach my $i ( 2 .. int( $number / 2 ) ) {
        $divisors++ if $number % $i == 0;
    }

    return $divisors;
}

sub main {
    my $number    = 1;
    my @solutions = ();

    while ( ++$number and scalar(@solutions) < 10 ) {
        push @solutions, $number if _divisors($number) == 8;
    }

    say join ', ', @solutions;
}

main();
