#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ [ 1, 1, 0 ], [ 1, 0, 1 ], [ 0, 0, 0 ] ],
    [ [ 1, 1, 0, 0 ], [ 1, 0, 0, 1 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 0 ] ],
);

for my $e (@examples) {
    my @output = flip_matrix($e);
    my $input  = join ', ', map { qq{[$_]} } map { join ', ', $_->@* } $e->@*;
    my $output = join ', ',
        map { qq{[$_]} } map { join ', ', $_->@* } @output;
    say <<~"END";
    Input:  \@matrix = ($input)
    Output:           ($output)
    END
}

sub flip_matrix ($matrix) {
    my $new_matrix;
    for my $row ( 0 .. -1 + scalar $matrix->@* ) {
        $new_matrix->[$row]->@* =
            map { ( $_ + 1 ) % 2 } reverse $matrix->[$row]->@*;
    }
    # display_matrix($matrix);
    # display_matrix($new_matrix);
    return $new_matrix->@*;
}

sub display_matrix ($matrix) {
    say join "\n", '', map { join ' ', $_->@* } $matrix->@*;
}
