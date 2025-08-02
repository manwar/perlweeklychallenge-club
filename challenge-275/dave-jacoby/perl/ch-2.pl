#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use List::Util qw{ first };

my @examples = (

    'a1c1e1',
    'a1b2c3d4',
    'b2b',
    'a16z',
);

for my $input (@examples) {
    my $output = replace_digits($input);

    say <<"END";
        Input:  '$input'
        Output: '$output'
END
}

sub replace_digits ($string) {
    state @digits   = ( 0 .. 9 );
    state @alphabet = ( 'a' .. 'z', 'a' .. 'z' );
    my $input = $string;
    for my $i ( 0 .. -1 + length $string ) {
        my $l = substr( $string, $i, 1 );
        if ( grep { /$l/ } @digits ) {
            my $p = get_previous_letter( $input, $i );
            my $n = first { $alphabet[$_] eq $p } 0 .. scalar @alphabet;
            my $m = $alphabet[ $l + $n ];
            substr( $string, $i, 1 ) = $m;
        }
    }
    return $string;
}

sub get_previous_letter ( $input, $index ) {
    state @digits = ( 0 .. 9 );
    while (1) {
        $index -= 1;
        my $l = substr( $input, $index, 1 );
        return $l unless grep { /$l/ } @digits;
    }
    die 'found no string';
}
