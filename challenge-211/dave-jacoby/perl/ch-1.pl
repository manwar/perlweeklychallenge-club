#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ max sum uniq };

my @examples = (

    [ [ 4, 3, 2, 1 ], [ 5, 4, 3, 2 ], [ 6, 5, 4, 3 ], ],
    [ [ 1, 2, 3 ], [ 3, 2, 1 ], ]
);

for my $e (@examples) {
    my $pad    = ' ' x 26;
    my $matrix = join "\n$pad", map { qq{[$_],} } map { join ', ', $_->@* }
        grep { scalar $_->@* } $e->@*;
    my $o = toeplitz($e);

    say <<"END";
    Input:  \@matrix =   [ $matrix 
                        ]
    Output: $o
END
}

sub toeplitz ($array) {
    for my $i ( 0 .. -1 + scalar $array->@* ) {
        my $t = _toeplitz( $array, $i, 0, $array->[$i][0] );
        return 'false' unless $t;
    }
    for my $i ( 1 .. -1 + scalar $array->[0]->@* ) {
        my $t = _toeplitz( $array, 0, $i, $array->[0][$i] );
        return 'false' unless $t;
    }
    return 'true';
}

sub _toeplitz ( $array, $x = 0, $y = 0, $v = 0 ) {
    if ( !defined $array->[$x][$y] ) { return 1 }
    if ( $array->[$x][$y] ne $v )    { return 0 }
    return _toeplitz( $array, $x + 1, $y + 1, $v );
}
