#!/usr/bin/env perl

use v5.36;

sub count_primes ($number) {
    if ( $number < 2 ) {
        return 0;
    }
    else {
        my @primes = (2);
      APPLICATIONS:
        foreach my $applicant ( 2 .. $number ) {
            for (@primes) {
                next APPLICATIONS if $applicant % $_ == 0;
            }
            push @primes, $applicant;
        }
        return scalar @primes;
    }
}

#| Run test cases
sub MAIN() {
    if (@ARGV) {
        say count_primes( $ARGV[0] );
    }
    else {
        use Test2::V0 qw( is plan );
        plan 3;

        is count_primes(10), 4, 'works for 10';
        is count_primes(1),  0, 'works for 1';
        is count_primes(20), 8, 'works for 20';
    }
}

MAIN();
