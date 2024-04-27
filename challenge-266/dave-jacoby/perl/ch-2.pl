#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @examples = (

    [ [ 1, 0, 0, 2 ], [ 0, 3, 4, 0 ], [ 0, 5, 6, 0 ], [ 7, 0, 0, 1 ], ],
    [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ], ],
    [ [ 1, 0, 2 ], [ 0, 3, 0 ], [ 4, 0, 5 ], ],
    [ [ 1, 0, 2 ], [ 0, 3, 0 ], [ 4, 3, 5 ], ],
);

for my $matrix (@examples) {
    my $output = x_matrix($matrix) ? 'true' : 'false';
    my $input  = display_matrix($matrix);

    say <<"END";
    Input: \$matrix = [
          $input, 
        ]
    Output: $output
END
}

sub display_matrix ($matrix) {
    return join ",\n          ",
        map { join ' ', '[', ( join ', ', $_->@* ), ']' } $matrix->@*;
}

# A square matrix is an X Matrix
# if all the elements on the main diagonal
#     and antidiagonal are non-zero
# and everything else are zero.
sub x_matrix ($matrix) {
    my $z = -1 + scalar $matrix->@*;
    my %diag;

    for my $i ( 0 .. $z ) {
        my $j = $z - $i;
        $diag{$i}{$i} = 1;
        $diag{$i}{$j} = 1;
    }

    for my $i ( 0 .. $z ) {
        for my $j ( 0 .. $z ) {
            my $k = $matrix->[$i][$j];
            my $d = $diag{$i}{$j} || 0;
            if ($d) {
                return 0 if $k == 0;
            }
            else {
                return 0 if $k != 0;
            }
        }
    }
    return 7;
}

