#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub _is_ugly {
    my $x = shift;

    # Keep dividing by 2, 3 and 5 as long as it leaves no remainder
    foreach my $d ( 2, 3, 5 ) {
        while ( $x % $d == 0 ) {
            $x /= $d;
        }
    }

    # If the result is 1, it's an ugly number
    return $x == 1 ? 1 : 0;
}

sub main {
    my $n = shift;

    # Sanity check
    die "You must provide a postive integer\n" unless defined $n;
    die "The value '$n' does not appear to be a positive integer\n" unless $n =~ /^[1-9][0-9]*$/;

    my $number = 0;
    while ($n) {
        --$n if _is_ugly( ++$number );
    }

    say $number;
}

main(@ARGV);
