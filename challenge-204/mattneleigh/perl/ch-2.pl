#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrix_data = (
    {
        matrix => [
            [ 1, 2 ],
            [ 3, 4 ]
        ],
        r => 1,
        c => 4
    },
    {
        matrix => [
            [ 1, 2, 3 ],
            [ 4, 5, 6 ]
        ],
        r => 3,
        c => 2
    },
    {
        matrix => [
            [ 1, 2 ]
        ],
        r => 3,
        c => 2
    }
);

print("\n");
foreach my $matrix_instance (@matrix_data){
    my $reshaped_matrix = reshape_matrix(
        $matrix_instance->{matrix},
        $matrix_instance->{r},
        $matrix_instance->{c}
    );

    printf(
        "\$matrix = %s\n\$r = %d\n\$c = %d\nOutput: %s\n\n",
        matrix_to_string($matrix_instance->{matrix}),
        $matrix_instance->{r},
        $matrix_instance->{c},
        defined($reshaped_matrix) ?
            matrix_to_string($reshaped_matrix)
            :
            "0"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Reshape a matrix into a new rectangular matrix (i.e. all rows have the same
# number of columns) of a specified set of dimensions
# Takes three arguments:
# * A reference to a matrix, which must consist of an array reference to a two
#   dimensional array, e.g.
#
#   [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]
#
#   This must be the case even for a matrix with a single row, e.g.
#
#   [ [ 1, 2, 3, 4 ] ]
#
# * The number of rows the reshaped matrix is to have
# * The number of columns the reshaped matrix is to have
# Returns on success:
# * A ref to a reshaped matrix into which data from the original has been
#   copied, now arranged in the specified number of rows and columns; the
#   internal arrangement of this matrix will meet the requirements specified
#   above
# Returns on error:
# * undef if the quantity of elements in the original matrix does not permit
#   rearrangement into a rectangular matrix of the specified dimensions
# NOTE: The original matrix will NOT be altered
################################################################################
sub reshape_matrix{
    my $matrix = shift();
    my $r = shift();
    my $c = shift();

    my @elements;

    # Copy the contents of the matrix into a
    # flat list
    foreach my $row (@{$matrix}){
        push(@elements, @{$row});
    }

    # Now that we know how many elements there
    # are, make sure we can produce a rectangular
    # matrix of the specified dimensions
    return(undef)
        unless((scalar(@elements) / $r) == $c);

    # Re-use $matrix to build the output matrix,
    # transferring the contents from the flat
    # list row by row
    $matrix = [];
    for(1 .. $r){
        push(@{$matrix}, [ splice(@elements, 0, $c) ]);
    }

    return($matrix);

}



################################################################################
# Produce a string representation of a matrix.
# Takes one argument:
# * A reference to a matrix, which must consist of an array reference to a two
#   dimensional array, e.g.
#
#   [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]
#
#   This must be the case even for a matrix with a single row, e.g.
#
#   [ [ 1, 2, 3, 4 ] ]
#
# Returns:
# * A string representation of the specified matrix, which matches the format
#   of the examples presented above
################################################################################
sub matrix_to_string{
    my $matrix = shift();

    return(
        sprintf(
            "[ %s ]",
            join(
                ", ",
                map(
                    sprintf(
                        "[ %s ]",
                        join(", ", @{$_})
                    ),
                    @{$matrix}
                )
            )
        )
    );

}



