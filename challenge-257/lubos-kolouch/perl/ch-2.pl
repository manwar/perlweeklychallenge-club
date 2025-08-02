use strict;
use warnings;

sub is_reduced_row_echelon {
    my ($matrix_ref)         = @_;
    my @matrix               = @{ $matrix_ref->[0] };  # Adjusting matrix access
    my $last_leading         = -1;
    my $zero_row_encountered = 0;

    for my $row_index ( 0 .. $#matrix ) {
        my $row     = $matrix[$row_index];
        my $leading = -1;

        for my $i ( 0 .. $#$row ) {
            my $element = $row->[$i];
            if ( $element != 0 ) {
                if ( $element == 1 ) {
                    $leading = $i;
                    last;
                }
                else {
                    return 0;
                }
            }
        }

        if ( $leading == -1 ) {
            $zero_row_encountered = 1;
            next;
        }

        if ($zero_row_encountered) {
            return 0;
        }

        if ( $leading <= $last_leading ) {
            return 0;
        }

        for my $r_index ( 0 .. $#matrix ) {
            next if $r_index == $row_index;
            if ( $matrix[$r_index][$leading] != 0 ) {
                return 0;
            }
        }

        $last_leading = $leading;
    }

    return 1;
}

# Test cases
use Test::More;
is( is_reduced_row_echelon( [ [ [ 1, 1, 0 ], [ 0, 1, 0 ], [ 0, 0, 0 ] ] ] ),
    0, "Test 1" );
is(
    is_reduced_row_echelon(
        [
            [
                [ 0, 1, -2, 0, 1 ],
                [ 0, 0, 0,  1, 3 ],
                [ 0, 0, 0,  0, 0 ],
                [ 0, 0, 0,  0, 0 ]
            ]
        ]
    ),
    1, "Test 2"
);
is(
    is_reduced_row_echelon(
        [ [ [ 1, 0, 0, 4 ], [ 0, 1, 0, 7 ], [ 0, 0, 1, -1 ] ] ]
    ),
    1, "Test 3"
);
is(
    is_reduced_row_echelon(
        [
            [
                [ 0, 1, -2, 0, 1 ],
                [ 0, 0, 0,  0, 0 ],
                [ 0, 0, 0,  1, 3 ],
                [ 0, 0, 0,  0, 0 ]
            ]
        ]
    ),
    0, "Test 4"
);
is( is_reduced_row_echelon( [ [ [ 0, 1, 0 ], [ 1, 0, 0 ], [ 0, 0, 0 ] ] ] ),
    0, "Test 5" );
is(
    is_reduced_row_echelon(
        [ [ [ 4, 0, 0, 0 ], [ 0, 1, 0, 7 ], [ 0, 0, 1, -1 ] ] ]
    ),
    0, "Test 6"
);

done_testing();
