use strict;
use warnings;

use v5.38;

sub count_change_v1( $str ) {
    $str =~ s/(.)\g1*/$1/gi;
    return -1 + length $str;
}

sub count_change_v2( $str ) {
    return scalar ( () = $str =~ /(.)\g1*/gi ) - 1;
}

my @inputs = (
    'pPeERrLl',
    'rRr',
    'GoO',
    'gooooo',
    'goOOood'
    );
for (@inputs) {
    say $_ . ' =v1=> ' . count_change_v1( $_ );
    say $_ . ' =v2=> ' . count_change_v2( $_ );
    say '****';
}
