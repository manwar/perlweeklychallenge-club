#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrix_pairs = (
    # Given case
    [
        [
            [ 1, 2 ],
            [ 3, 4 ]
        ],
        [
            [ 5, 6 ],
            [ 7, 8 ]
        ]
    ],

    # Additional test case(s)
    [
        [
            [ 1, 2, 3, 4, 5, 6, 7, 8 ]
        ],
        [
            [  9 ],
            [ 10 ],
            [ 11 ],
            [ 12 ],
            [ 13 ],
            [ 14 ],
            [ 15 ],
            [ 16 ]
        ]
    ]
);

print("\n");
foreach my $pair (@matrix_pairs){
    my @k_prod = @{kronecker_product($pair->[0], $pair->[1])};

    print_matrix(\@k_prod, "    ");
    print("\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the Kronecker product of two matrices A and B
# Takes two arguments:
# * Matrix A, which must consist of a ref to an array of arrays whose contents
#   form a rectangular grid of scalar numerical values, e.g.:
#
#   $A = [
#      [ 1, 2, 3 ],
#      [ 4, 5, 6 ]
#   ];
#
# * Matrix B, subject to the same requirements as matrix A
# Returns:
# * A ref to a matrix that contains the Kronecker product of A and B; this
#   will conform to the format described above for A
# NOTE: There are no constraints on the relative dimensions of A and B so long
# as both are rectangular
################################################################################
sub kronecker_product{
    my $a = shift();
    my $b = shift();

    my @c = ();

    for my $aj (0 .. $#$a){
        for my $ai (0 .. $#{$a->[0]}){
            for my $bj (0 .. $#$b){
                for my $bi (0 .. $#{$b->[0]}){
                    $c[$aj*scalar(@{$b})+$bj][$ai*scalar(@{$b->[0]})+$bi]
                        = $a->[$aj][$ai] * $b->[$bj][$bi];
                }
            }
        }
    }

    return(\@c);

}



################################################################################
# Print the contents of a matrix to STDOUT
# Takes two arguments:
# * A matrix, which must consist of a ref to an array of arrays whose contents
#   are to be printed to STDOUT, e.g.:
#
#   $M = [
#       [ 1, 2, 3, 4 ],
#       [ 5, 6, 7, 8 ]
#   ]; 
#
# * An optional string to prepend to each line of the output written to STDOUT,
#   which can be used to establish an indent if desired
# Returns no meaningful value
################################################################################
sub print_matrix{
    my $matrix = shift();
    my $indent = shift();

    my $max = 0;
    my $element_format;

    $indent = "" unless(defined($indent));

    # Determine the size, in characters, of the
    # largest item in the matrix- done this way
    # instead of counting digits with log() so
    # non-numerical values can be accommodated
    foreach(@{$matrix}){
        foreach(@{$_}){
            $max = length($_)
                if(length($_) > $max);
        }
    }

    # Produce the output format for each
    # element
    $element_format = "%".$max."s";

    # Loop and print
    foreach(@{$matrix}){
        printf(
            "%s[ %s ]\n",
            $indent,
            join(
                " ",
                map(sprintf($element_format, $_), @{$_})
            )
        );
    }

}



