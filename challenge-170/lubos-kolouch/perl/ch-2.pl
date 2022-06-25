package main;
use strict;
use warnings;

sub get_kronecker_product {
    my $matrix = shift;

    my @result;

    my $matrix_a = %$matrix{"a"};
    my $matrix_b = %$matrix{"b"};

    # will be used in calculating the right position in the output
    my $row_len = scalar @$matrix_a;

    # it is the same, just for code readability
    my $col_len = scalar @$matrix_a;

    # process the matrix a row by row
    # enumarate() like in Python would help to get rid of the pos variables...

    my $a_row_pos = 0;

    # row by row
    for my $row (@$matrix_a) {
        my $a_col_pos = 0;

        # column by column
        for my $a_item (@$row) {

            # mutiply each number with matrix b

            my $b_row_pos = 0;
            for my $b_row (@$matrix_b) {
                my $b_col_pos = 0;

                for my $b_item (@$b_row) {

                    # calculate the right position in the output matrix
                    $result[ $a_row_pos * $row_len + $b_row_pos ]
                        [ $a_col_pos * $col_len + $b_col_pos ]
                        = $a_item * $b_item;

                    $b_col_pos++;
                }
                $b_row_pos++;
            }
            $a_col_pos++;
        }
        $a_row_pos++;
    }

    return \@result;
}

use Test::More;

my %in_hash = (
    "a" => [ [ 1, 2 ], [ 3, 4 ] ],
    "b" => [ [ 5, 6 ], [ 7, 8 ] ],
);

is_deeply(
    get_kronecker_product( \%in_hash ),
    [   [ 5,  6,  10, 12 ],
        [ 7,  8,  14, 16 ],
        [ 15, 18, 20, 24 ],
        [ 21, 24, 28, 32 ]
    ]
);

done_testing;
1;
