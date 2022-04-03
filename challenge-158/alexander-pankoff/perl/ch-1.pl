#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use List::Util qw(sum0);

run() unless caller();

sub run() {
    say join( ', ', additive_primes() );
}

sub additive_primes($max = 100) {
    return grep { is_prime($_) && is_prime( digit_sum($_) ) } 2 .. $max;
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

# from challenge 149 task 1
sub digit_sum($x) {
    my $sum = sum0 split( '', $x );

    return $sum;
}
