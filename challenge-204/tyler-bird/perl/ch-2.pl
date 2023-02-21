 package main;

use strict;
use warnings;
use Data::Dumper;

my $original_matrix = [
        [1,2],
        [3,4]
];

print Dumper( matrixReshape($original_matrix, 1, 4) );

$original_matrix = [
        [1,2,3],
        [4,5,6]
];

print Dumper( matrixReshape($original_matrix, 3, 2 ) );

sub matrixReshape
{
    my ($matrix_aref, $rows, $columns) = @_;

    my $current_rows = scalar(@{$matrix_aref});

    if($current_rows == 0) {
        return $matrix_aref;
    }

    my $current_columns = scalar( @{$matrix_aref->[0]} );

    if($current_columns == 0) {
        return $matrix_aref;
    }

    my $new_size = $rows * $columns;

    my $current_size = $current_rows * $current_columns;

    if($new_size != $current_size) {
        return 0;
    }

    my $result = [

    ];
    my $k = 0;
    my $l = 0;

    for (my $i = 0; $i < $rows; $i++) {
        for(my $j = 0; $j < $columns; $j++) {
                $result->[$i]->[$j] = $matrix_aref->[$k]->[$l];
                if($l == $current_columns - 1) {
                    $k++;
                }
                $l = ($l + 1) % $current_columns;
       }
    }

    return $result;
}

1;

