#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    { row => 2, col => 3, locations => [ [ 0, 1 ], [ 1, 1 ] ] },
    { row => 2, col => 2, locations => [ [ 1, 1 ], [ 0, 0 ] ] },
    { row => 3, col => 3, locations => [ [ 0, 0 ], [ 1, 2 ], [ 2, 1 ] ] },
    { row => 1, col => 5, locations => [ [ 0, 2 ], [ 0, 4 ] ] },
    {
        row       => 4,
        col       => 2,
        locations => [ [ 1, 0 ], [ 3, 1 ], [ 2, 0 ], [ 0, 1 ] ]
    },
);

for my $input (@examples) {
    my $row  = $input->{row};
    my $col  = $input->{col};
    my $locs = join ',', map { qq{[$_]} }
        map { join ',', $_->@* } $input->{locations}->@*;
    my $output = odd_matrix($input);
    say <<"END";
        Input:  \$row = $row,
                \$col = $col,
                \@locations = ($locs)
        Output: $output
END
}

sub odd_matrix($input) {
    my $row = $input->{row};
    my $col = $input->{col};
    my @matrix;
    for my $r ( 0 .. -1 + $row ) {
        for my $c ( 0 .. -1 + $col ) {
            $matrix[$r][$c] = 0;
        }
    }
    my @locations = $input->{locations}->@*;
    for my $loc (@locations) {
        my ( $x, $y ) = $loc->@*;
        for my $c ( 0 .. -1 + $col ) {    # rows
            $matrix[$x][$c]++;
        }

        for my $r ( 0 .. -1 + $row ) {    # columns
            $matrix[$r][$y]++;
        }
    }
    # display_matrix( \@matrix );
    return scalar grep { ( $_ % 2 ) } map { $_->@* } @matrix;
}

sub display_matrix ($matrix) {
    say join "\n", '', map { join ' ', "\t", '[', $_->@*, ']' } $matrix->@*;
}
