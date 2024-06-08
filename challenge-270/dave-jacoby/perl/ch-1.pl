#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

my @examples = (

    [ [ 1, 0, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ], ],
    [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ],
    ],

);
for my $example (@examples) {
    my $output = special_positions($example);
    my $input = display_matrix( $example);
say <<"END";
    Input:  \$matrix = 
        [ $input ]
    Output: $output
END
}

sub special_positions ($matrix) {
    my $output = 0;
OUTER: for my $i ( 0 .. -1 + scalar keys $matrix->@* ) {
        for my $j ( 0 .. -1 + scalar keys $matrix->[$i]->@* ) {
            for my $x ( 0 .. -1 + scalar keys $matrix->[$i]->@* ) {
                my $v = $matrix->[$i][$x];
                next OUTER if $v == 0 && $x == $j;
                next OUTER if $v != 0 && $x != $j;
            }
            for my $y ( 0 .. -1 + scalar keys $matrix->@* ) {
                my $v = $matrix->[$y][$j];
                next OUTER if $v == 0 && $y == $i;
                next OUTER if $v != 0 && $y != $i;
            }
            $output++;
        }
    }
    return $output;
}

sub display_matrix ($matrix) {
    return join ",\n          ",
        map { join ' ', '[', ( join ', ', $_->@* ), ']' } $matrix->@*;
}
