#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $count = 5;
my @cardanos;

@cardanos = calculate_first_cardano_triplets($count);

printf("\nThe first %d Cardano Triplets are:\n", scalar(@cardanos));
foreach(@cardanos){
    printf("  (%s)\n", join(", ", @{$_}));
}
print("\n");


exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find a specified number of the first Cardano Triplets, numbers (A, B, C) that
# meet specified parameters (see link below)
# Takes two arguments:
# * The number of Triplets to find; if this number is zero (0), ALL Cardano
#   Triplets whose members' sum is less than or equal to the maximum sum value
#   (see below) will be found; if there aren't that many triplets within the
#   search range, the returned list (see farther below) will be shorter than
#   specified but will contain all Triplets within the range
# * The maximum sum of A, B, and C up to which we'll search for Triplets; if
#   this argument is omitted or is false a default of 1000 will be used
# Returns:
# * A list of refs to the Cardano Triplets found, e.g.:
#   (
#       [ 2, 1, 5 ],
#       [ 5, 1, 52 ],
#       [ 5, 2, 13 ],
#       ...
#   )
# NOTES: Cardano Triplets are described here:
# https://projecteuler.net/problem=251
# Which particular triplets you get will depend on the value of the maximum
# sum.
################################################################################
sub calculate_first_cardano_triplets{
    my $count = int(shift());
    my $max = shift();

    my @cardanos = ();
    my $a;
    my $b;
    my $c;

    if(defined($max) && $max){
        $max = int($max);
    } else{
        $max = 1000;
    }

    # Traditionally this is done with the
    # variables adding up to some
    # particular maximum value...
    for($a=1; $a<=($max - 2); $a++){
        for($b=1; $b<=($max - $a - 1); $b++){
            for($c=1; $c<=($max - $a - $b); $c++){
                my $b_sqrt_c = $b * sqrt($c);

                # The calculated value should be zero
                # if we have a Cardano Triplet, but it
                # could be slightly off because of
                # round-off error
                if(
                    abs(cbrt($a + $b_sqrt_c) + cbrt($a - $b_sqrt_c) - 1)
                    <
                    0.000000001
                ){
                    # We have a Cardano Triplet
                    push(@cardanos, [ $a, $b, $c ]);

                    # Break out of all loops if there's a
                    # count defined and we've hit it
                    $max = 0
                        if($count && (scalar(@cardanos) == $count));
                }

            }
        }
    }

    return(@cardanos);

}



################################################################################
# Compute the cube root of a number
# Takes one argument:
# * The number whose cube root is desired
# Returns:
# * The cube root
################################################################################
sub cbrt{
    my $x = shift();

    if($x < 0){

        # $x is negative; play some sign games
        return(-((-$x) ** (1 / 3)));

    } else{

        # $x is positive; very straightforward
        return($x ** (1 / 3));

    }

}



