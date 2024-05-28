#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ bitwise fc postderef say signatures state };

use List::Util qw{max};

my @examples = (

    [ [ 0, 1 ], [ 1, 0 ], ],
    [ [ 0, 0, 0 ], [ 1, 0, 1 ], ],
    [ [ 0, 0 ], [ 1, 1 ], [ 0, 0 ], ],
);
for my $example (@examples) {
    use JSON;
    my $j      = JSON->new->pretty->canonical;
    my $output = maximum_ones($example);
    my $input  = display_matrix($example);
    say <<"END";
    Input:  \$matrix = 
        [ $input ]
    Output: $output
END
}

sub maximum_ones ($matrix) {
    my @rows = (0);
    for my $r ( 1 .. scalar @$matrix ) {
        $rows[$r] = scalar grep { $_ == 1 } $matrix->[ $r - 1 ]->@*;
    }
    my $max = max @rows;
    my ($i) = grep { $rows[$_] == $max } 0 .. -1 + scalar @rows;
    return $i;
}

sub display_matrix ($matrix) {
    return join ",\n          ",
        map { join ' ', '[', ( join ', ', $_->@* ), ']' } $matrix->@*;
}
