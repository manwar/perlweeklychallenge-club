#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 10;

printf(
    "\nThe first %d Pernicious Numbers are:\n    %s\n\n",
    $n,
    join(", ", calculate_pernicious_numbers($n))
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the first N Pernicious Numbers- positive integers whose binary
# representation has a number of 1's that is prime
# Takes one argument:
# * The number N of Pernicious Numbers to calculate; this must be positive
# Returns on success:
# * A list of the first N Pernicious Numbers; only numbers that can be
#   represented as a 64-bit integer will be examined, so the length of the list
#   will be limited in that regard
# Returns on error:
# * undef if N is not positive
################################################################################
sub calculate_pernicious_numbers{
    use POSIX;

    my $n = int(shift());

    return(undef)
        unless($n > 0);

    # Since we aren't dealing with bigint,
    # we will never need to check primality
    # for a number bigger than 64...
    my $prime_table =
        "00110101000101000101000100000101000001000101000100000100000101000"; 
    my $num = 3;
    my @pernicious;

    # Loop until we've found enough
    # Pernicious Numbers, or we hit the max
    # int size, whichever comes first
    while(scalar((@pernicious) < $n) && ($num < 2**64)){
        my $ones = 0;

        # Count the number of ones in the binary
        # representation of $num
        for(0 .. ceil(log($num)/log(2))){
            $ones++
                if($num & (0x01 << $_));
        }

        # If the number of ones in the $num is
        # prime, store it
        push(@pernicious, $num)
            if(substr($prime_table, $ones, 1));

        $num++;
    }

    return(@pernicious);

}



