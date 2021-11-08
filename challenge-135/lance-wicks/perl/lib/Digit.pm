package Digit;

#use Moo;

use strict;
use warnings;

sub middle {
    my ( $self, $integer ) = @_;

    $integer = abs( $integer || 0 );

    return 'Too short'             if length $integer < 3;
    return 'Even number of digits' if !( $integer % 2 );

    my @digits = split '', $integer;

    my $start = ( ( ( length $integer ) - 1 ) / 2 ) - 1;
    return join '', @digits[ $start .. $start + 2 ];
}

1;
