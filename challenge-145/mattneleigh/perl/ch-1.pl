#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @pairs = (
    # Given case
    [
        [ 1, 2, 3 ],
        [ 4, 5, 6 ]
    ],

    # Additional test cases
    [
        [  1,  2,  3,  4,  5,  6,  7,  8,  9 ],
        [ 10, 11, 12, 13, 14, 15, 16, 17, 18 ]
    ],
    [
        [ 1, 2, 3, 4, 5 ],
        [ 1, 2, 3, 4 ]
    ]
);
my $pair;

foreach $pair (@pairs){
    my $dot_product = dot_product($pair->[0], $pair->[1]);

    printf("\@a = (%s);\n", join(", ", @{$pair->[0]}));
    printf("\@b = (%s);\n", join(", ", @{$pair->[1]}));
    printf(
        "Dot product = %s\n\n",
        defined($dot_product) ? $dot_product : "Undefined due to error"
    );
}


exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the dot product of two vectors
# Takes two arguments:
# * A reference to an array of scalar numeric values, A
# * A reference to an array of scalar numeric values, B
# Returns on success:
# * The dot product- a single scalar value- of A and B.
# Returns on error:
# * undef if A and B do not have the same number of members
################################################################################
sub dot_product{
    my $a = shift();
    my $b = shift();

    my $i = scalar(@{$a});

    # Make sure both arrays are the same
    # length
    return(undef)
        unless($i == scalar(@{$b}));

    my $sum = 0;

    # Accumulate the sum of the products
    # of all corresponding members of
    # each array
    while($i--){
        $sum += $a->[$i] * $b->[$i];
    }

    return($sum);

}



