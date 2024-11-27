#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{first};

my @examples = (

    [ 2, 1, 4, 3 ],
    [ 2, 4, 1, 3 ],
    [ 1, 2, 3, 4, 5 ],
    [ 9, 8, 7, 6, 2, 3, 4, 5, 1 ],
);

for my $example (@examples) {
    my $output = semi_ordered_permute( $example->@* );
    my $input  = join ', ', $example->@*;
    say <<"END";
    Input:  \@ints = ($input)
    Output: $output
END
}

sub semi_ordered_permute (@array) {
    my $min   = 1;
    my $max   = scalar @array;
    my $steps = 0;
    while ( $array[0] != $min ) {
        my $i = first { $min == $array[$_] } 0 .. -1 + $max;
        ( $array[$i], $array[ $i - 1 ] ) = ( $array[ $i - 1 ], $array[$i] );
        $steps++;
    }
    while ( $array[-1] != $max ) {
        my $i = first { $max == $array[$_] } 0 .. -1 + $max;
        ( $array[$i], $array[ $i + 1 ] ) = ( $array[ $i + 1 ], $array[$i] );
        $steps++;
    }
    return $steps;
}
