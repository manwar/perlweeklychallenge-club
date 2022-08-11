#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @numbers = ( 5724, 5727 );

print("\n");
foreach my $n (@numbers){
    printf(
        "%d is %sa valid number\n",
        $n,
        validate_damm_checksum($n) ? "" : "not "
    );
}
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the checksum of a number using the Damm algorithm; see
# https://en.wikipedia.org/wiki/Damm_algorithm for a description of the
# procedure
# Takes one argument:
# * The number N to examine
# Returns:
# * The Damm checksum of N, which will be a single digit
################################################################################
sub calculate_damm_checksum{
    my $n = int(shift());

    my @damm_table = (
        [ 0, 3, 1, 7, 5, 9, 8, 6, 4, 2 ],
        [ 7, 0, 9, 2, 1, 5, 4, 8, 6, 3 ],
        [ 4, 2, 0, 6, 8, 7, 1, 3, 5, 9 ],
        [ 1, 7, 5, 0, 9, 8, 3, 4, 2, 6 ],
        [ 6, 1, 2, 3, 0, 4, 5, 9, 7, 8 ],
        [ 3, 6, 7, 4, 2, 0, 9, 5, 8, 1 ],
        [ 5, 8, 6, 9, 7, 2, 0, 1, 3, 4 ],
        [ 8, 9, 4, 5, 3, 6, 2, 0, 1, 7 ],
        [ 9, 4, 3, 8, 6, 1, 7, 2, 0, 5 ],
        [ 2, 5, 8, 1, 4, 3, 6, 7, 9, 0 ]
    );
    my $interim = 0;

    # Loop over each digit, stepping through the
    # table as described in the algorithm
    foreach my $digit (split('', $n)){
        $interim = $damm_table[$interim][$digit];
    }

    return($interim);

}



################################################################################
# Determine whether a number with included Damm checksum digit at the end is
# valid
# Takes one argument:
# * The number N to examine, which should have as its last digit the Damm
#   checksum of the preceding digits
# Returns on success:
# * 1 if N has a valid Damm checksum as its last digit
# * 0 if N does not have a valid Damm checksum as its last digit
# Returns on error:
# * undef if N does not have at least two digits
################################################################################
sub validate_damm_checksum{
    my $n = int(shift());

    # We require at least two digits
    return(undef)
        if(length($n) < 2);

    # The checksum of a valid number should be
    # zero...
    return(
        calculate_damm_checksum($n) ? 0 : 1
    );

}



