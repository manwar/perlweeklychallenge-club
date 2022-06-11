#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use List::Util qw(first sum0 product);

run() unless caller();

sub run() {
    my $max = 100000;
    say "Factorions <= $max:";
    for ( 1 .. $max ) {
        my $fn = ( \&is_factorion, \&is_factorion_a014080 )[ int( rand(2) ) ];
        say $_ if $fn->($_);
    }
}

sub is_factorion($n) {
    my @digits                      = split( m//, $n );
    my $sum_of_factorials_of_digits = sum0( map { fac($_) } @digits );

    return $n == $sum_of_factorials_of_digits;
}

sub fac($n) {
    product( 1 .. $n );
}

sub is_factorion_a014080($n) {
    ## complete list of all factorians - see https://oeis.org/A014080
    state @A014080 = ( 1, 2, 145, 40585 );
    first { $n == $_ } @A014080;
}
