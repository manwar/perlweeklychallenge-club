#!/usr/bin/perl
use strict;
use warnings;

sub is_prime {
    my $n = shift;
    return 0 if $n < 2;
    for ( my $i = 2 ; $i <= sqrt($n) ; $i++ ) {
        return 0 if ( $n % $i == 0 );
    }
    return 1;
}

my $p             = 2;
my $euclid_number = 3;

while ( is_prime($euclid_number) ) {
    $p++;
    while ( !is_prime($p) ) {
        $p++;
    }
    $euclid_number = ( 2**( $p - 1 ) ) * ( ( 2**$p ) - 1 );
}

print "The smallest Euclid number that is not prime is: ", $euclid_number, "\n";
