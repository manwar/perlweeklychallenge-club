package main;
use strict;
use warnings;
use Math::Prime::Util qw/is_prime next_prime/;
use List::Util qw/sum/;

sub get_additive_primes {
    my $limit = shift;

    my $pos = 1;
    my @primes;
    while ( $pos <= $limit ) {

        push @primes, $pos
            if is_prime($pos)
            and is_prime( sum( split //, $pos ) );
        $pos = next_prime($pos);
    }

    return \@primes;
}

use Test::More;

is_deeply( get_additive_primes(100),
    [ 2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89 ] );

done_testing;
1;
