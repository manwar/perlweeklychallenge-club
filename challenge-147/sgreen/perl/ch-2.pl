#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub pentagon_number {
    my $n = shift;
    return $n * ( 3 * $n - 1 ) / 2;
}

sub is_pentagon_number {
    my $x = shift;
    my $n = sqrt( 24 * $x + 1 ) + 1;
    return ( $n == int($n) and $n % 6 == 0 ) ? ( $n / 6 ) : undef;
}

sub main {
    my $n1 = 2;
    while (1) {
        my $p1 = pentagon_number($n1);
        foreach my $n2 ( 1 .. $n1 - 1 ) {
            my $p2 = pentagon_number($n2);

            my $s1 = is_pentagon_number( $p1 + $p2 );
            my $s2 = is_pentagon_number( $p1 - $p2 );

            if ( defined $s1 and defined $s2 ) {
                say "P($n1) + P($n2) = $p1 + $p2 = ", $p1 + $p2, "  = P($s1)";
                say "P($n1) - P($n2) = $p1 - $p2 = ", $p1 - $p2, "  = P($s2)";
                return;
            }
        }
        $n1++;
    }
}

main();
