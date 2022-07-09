package main;
use strict;
use warnings;
use Math::Prime::Util qw/next_prime/;
use Math::Combinatorics;
use List::Util qw/sum/;
use Data::Dumper;

sub generate_primes {
    my $limit = shift;

    my @primes = (2);

    while ( $primes[-1] < $limit ) {
        push @primes, next_prime( $primes[-1] );
    }

    return \@primes;
}

sub find_prime_partitions {
    my ( $m, $n ) = @_;

    # Create a generator of combinations
    my $combinat = Math::Combinatorics->new(
        count => $n,
        data  => generate_primes($m),
    );

    my @result;

    # Loop throug the combinator, exit if found a valid combination
    while ( my @comb = $combinat->next_combination ) {
        my $arr_sum = sum(@comb);
        push @result, \@comb if $arr_sum == $m;
    }

    warn Dumper \@result;
    return \@result;
}

use Test::More;

# the tests fail most of the time as ->next_combination is returning the elements in unpredictable order
is_deeply( find_prime_partitions( 18, 2 ), [ [ 5, 13 ], [ 7, 11 ] ] );
is_deeply( find_prime_partitions( 19, 3 ), [ [ 3, 5, 11 ] ] );
done_testing;
1;
