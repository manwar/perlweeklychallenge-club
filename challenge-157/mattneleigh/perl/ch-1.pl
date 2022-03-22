#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @sets = (
    [ 1, 3, 5, 6,  9 ], 
    [ 2, 4, 6, 8, 10 ], 
    [ 1, 2, 3, 4,  5 ]
);
my $set;

print("\n");
foreach $set (@sets){
    printf(
        "Input: \@n = (%s)\nOutput: AM = %0.2f, GM = %0.2f, HM = %0.2f\n\n",
        join(", ", @{$set}),
        arithmetic_mean(@{$set}),
        geometric_mean(@{$set}),
        harmonic_mean(@{$set})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the arithmetic mean of a list of numbers
# Takes one argument:
# * A list of numbers
# Returns:
# * The arithmetic mean of the numbers in the provided list
################################################################################
sub arithmetic_mean{
    my $sum = 0;

    foreach(@ARG){
        $sum += $_;
    }

    return(
        $sum / scalar(@ARG)
    );

}



################################################################################
# Calculate the geometric mean of a list of numbers
# Takes one argument:
# * A list of numbers
# Returns:
# * The geometric mean of the numbers in the provided list
################################################################################
sub geometric_mean{
    my $product = 1;

    foreach(@ARG){
        $product *= $_;
    }

    return(
        abs($product) ** (1 / scalar(@ARG))
    );

}



################################################################################
# Calculate the harmonic mean of a list of numbers
# Takes one argument:
# * A list of numbers
# Returns:
# * The harmonic mean of the numbers in the provided list
################################################################################
sub harmonic_mean{
    my $sum = 0;

    foreach(@ARG){
        $sum += 1 / $_;
    }

    return(
        scalar(@ARG) / $sum
    );

}



