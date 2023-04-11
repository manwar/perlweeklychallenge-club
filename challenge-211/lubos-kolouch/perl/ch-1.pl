#!/usr/bin/perl
use strict;
use warnings;

sub is_toeplitz {
    my ($matrix) = @_;
    my $rows     = @$matrix;
    my $cols     = @{ $matrix->[0] };

    for ( my $i = 0 ; $i < $rows - 1 ; $i++ ) {
        for ( my $j = 0 ; $j < $cols - 1 ; $j++ ) {
            if ( $matrix->[$i]->[$j] != $matrix->[ $i + 1 ]->[ $j + 1 ] ) {
                return 0;
            }
        }
    }
    return 1;
}

# Test with example matrices
my @matrix1 = ( [ 4, 3, 2, 1 ], [ 5, 4, 3, 2 ], [ 6, 5, 4, 3 ], );

my @matrix2 = ( [ 1, 2, 3 ], [ 3, 2, 1 ], );

print is_toeplitz( \@matrix1 ) ? "true\n" : "false\n";
print is_toeplitz( \@matrix2 ) ? "true\n" : "false\n";
