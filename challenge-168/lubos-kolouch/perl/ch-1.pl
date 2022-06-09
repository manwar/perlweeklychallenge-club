package main;
use strict;
use warnings;
use Math::Prime::Util qw(is_prime);

sub generate_perrin_sequence {
    my $n               = shift;
    my @perrin_sequence = ( 3, 0, 2 );

    my %perrin_primes;

    while ( scalar keys %perrin_primes < $n ) {
        my $next_number = $perrin_sequence[-3] + $perrin_sequence[-2];
        push @perrin_sequence, $next_number;
        $perrin_primes{$next_number} = 1 if is_prime($next_number);
    }

    my @primes = sort { $a <=> $b } keys %perrin_primes;

    return \@primes;
}

use Test::More;

is_deeply(
    generate_perrin_sequence(13),
    [   2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193,
        792606555396977
    ]
);

done_testing;
1;
