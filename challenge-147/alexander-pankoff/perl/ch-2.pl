#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say signatures';
no warnings qw'experimental::signatures';

use List::Util qw(first);

run() unless caller();

sub run() {
    say join( ', ', @{ find_first_pair() } );
}

sub find_first_pair() {
    my $found;

    my @pentagon_numbers;

    my $i = 2;
    for ( my $i = 2 ; !$found ; $i++ ) {
        my $p     = pentagon_number($i);
        my @pairs = map { [ $_, $p ] } @pentagon_numbers;
        push @pentagon_numbers, $p;
        my $found = first { check(@$_) } @pairs;
        if ($found) {
            return $found;
        }
    }

}

# Pentagon numbers can be defined as P(n) = n(3n - 1)/2.
sub pentagon_number($n) {
    return $n * ( 3 * $n - 1 ) / 2;
}

sub check ( $a, $b ) {
    return is_pentagon_number( $a + $b )
      && is_pentagon_number( abs( $a - $b ) );

}

# https://en.wikipedia.org/wiki/Pentagonal_number#Tests_for_pentagonal_numbers
sub is_pentagon_number($x) {
    my $n = ( sqrt( 24 * $x + 1 ) + 1 ) / 6;
    return $n == int($n);
}
