#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'none';

sub get_primes {
    my @primes = ();

    # Return a list of all primes between 2 and 50 (being 100 ÷ 2)
  I: foreach my $i ( 2 .. 50 ) {
        foreach my $d ( 2 .. $i / 2 ) {
            # If the number is divisable by something other than one and
            #  itself, it's not a prime
            if ( $i % $d == 0 ) {
                next I;
            }
        }

        # It's a prime
        push @primes, $i;
    }

    return @primes;
}

sub main {
    my @primes     = get_primes;
    my @semiprimes = ();

  I: foreach my $i (@primes) {
        foreach my $j (@primes) {
            my $x = $i * $j;

            next I if $x > 100;

            if ( none { $x == $_ } @semiprimes ) {
                push @semiprimes, $x;
            }
        }
    }

    @semiprimes = sort { $a <=> $b } @semiprimes;
    say join ', ', @semiprimes;
}

main();
