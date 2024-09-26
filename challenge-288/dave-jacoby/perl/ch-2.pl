#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ min max };

my @examples = (

    [
        [ 'x', 'x', 'x', 'x', 'o' ],
        [ 'x', 'o', 'o', 'o', 'o' ],
        [ 'x', 'o', 'o', 'o', 'o' ],
        [ 'x', 'x', 'x', 'o', 'o' ],
    ],
    [
        [ 'x', 'x', 'x', 'x', 'x' ],
        [ 'x', 'o', 'o', 'o', 'o' ],
        [ 'x', 'x', 'x', 'x', 'o' ],
        [ 'x', 'o', 'o', 'o', 'o' ],
    ],
    [
        [ 'x', 'x', 'x', 'o', 'o' ],
        [ 'o', 'o', 'o', 'x', 'x' ],
        [ 'o', 'x', 'x', 'o', 'o' ],
        [ 'o', 'o', 'o', 'x', 'x' ],
    ]

);

# create a larger random matrix
my $random;
for my $i ( 0 .. 9 ) {
    for my $j ( 0 .. 9 ) {
        $random->[$i][$j] = int rand 2 ? 'x' : 'o';
    }
}
push @examples, $random;

for my $example (@examples) {
    my $input  = display_matrix($example);
    my $output = contiguous_block($example);
    say <<"END";
    Input:  \$matrix = [
          $input
        ]
    Output: $output
END
}

sub contiguous_block ($matrix) {
    my @list;
    for my $x ( 0 .. -1 + scalar $matrix->@* ) {
        for my $y ( 0 .. -1 + scalar $matrix->[$x]->@* ) {
            my $array = [];
            push $array->@*, [ $x, $y ];
            push @list,      _contiguous_block( $matrix, $array );
        }
    }
    return max @list;
}

sub _contiguous_block ( $matrix, $array ) {
    my $maxx   = scalar $matrix->@*;
    my $maxy   = scalar $matrix->[0]->@*;
    my $firstx = $array->[0][0];
    my $firsty = $array->[0][1];
    my $firstv = $matrix->[$firstx][$firsty];
    my @output;
    my ( $x, $y ) = $array->[-1]->@*;
    my @map;
    map { $map[ $_->[0] ][ $_->[1] ] = 1 } $array->@*;

    #  no diagonals, only left right up and down
    my @ij = ( [ 0, 1 ], [ 0, -1 ], [ 1, 0 ], [ -1, 0 ], );
    for my $ij (@ij) {
        my ( $i, $j ) = @$ij;
        my $xx = $i + $x;
        my $yy = $j + $y;

        # keep X in bounds
        next if $xx < 0;
        next if $xx >= $maxx;

        # keep Y in bounds
        next if $yy < 0;
        next if $yy >= $maxy;

        # don't double-count
        next if defined $map[$xx][$yy];

        # make sure we're following the right character
        my $kk = defined $map[$xx][$yy] ? 1 : 0;
        my $vv = $matrix->[$xx][$yy];
        next if $vv ne $firstv;

        my $new_array = [];
        push $new_array->@*, $array->@*;
        push $new_array->@*, [ $xx, $yy ];
        push @output,        _contiguous_block( $matrix, $new_array );
    }

    # if there are functions that returned, meaning this
    # isn't a final position
    if ( scalar @output ) {
        return @output;
    }

    # if there are no returning functions, meaning this
    # IS a final position
    else {
        return scalar @$array;
    }
}

sub display_matrix ($matrix) {
    return join ",\n          ", map {
        join ' ', '[', ( join ', ', map { qq{'$_'} } $_->@* ), ']'
    } $matrix->@*;
}
