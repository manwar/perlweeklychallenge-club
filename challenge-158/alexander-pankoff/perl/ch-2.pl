#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

run() unless caller();

sub run() {

    say join( ', ', cuban_primes() );

}

sub cuban_primes($max = 1000) {

    my @cubans    = ();
    my $i         = 1;
    my $candidate = 0;
    while ( $candidate <= $max ) {
        $candidate = centered_hexagonal_number($i);
        push @cubans, $candidate if is_prime($candidate);
        $i += 1;
    }
    return @cubans;

}

# from challenge 150 task 2
sub is_prime($x) {
    return 0 if $x <= 1;
    return 1 if $x <= 3;
    for ( my $i = 2 ; $i <= sqrt($x) ; $i++ ) {
        return 0 if $x % $i == 0;
    }
    return 1;
}

sub centered_hexagonal_number($y) {
    return 3 * $y * $y + 3 * $y + 1;
}
