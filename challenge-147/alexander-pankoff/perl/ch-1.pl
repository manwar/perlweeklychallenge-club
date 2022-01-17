#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say signatures';
no warnings qw'experimental::signatures';

use Data::Dumper;
use List::Util qw(all);

run() unless caller();

sub run() {
    say join( ", ", left_truncatable_primes(20) );
}

sub left_truncatable_primes($n) {

    my @primes = ();
    for ( my $i = 2 ; @primes <= $n ; $i++ ) {
        push @primes, $i if is_left_truncatable_prime($i);

    }

    return @primes;
}

sub is_left_truncatable_prime($x) {
    return 0 if $x =~ /0/;
    return 0 if !is_prime($x);
    return 1 if length $x == 1;

    return is_left_truncatable_prime( substr( $x, 1 ) );

}

sub is_prime($x) {

    return 0 if $x < 2;
    return 1 if $x < 4;

    for ( my $i = 2 ; $i <= sqrt($x) ; $i++ ) {
        return 0 if $x % $i == 0;
    }

    return 1;

}
