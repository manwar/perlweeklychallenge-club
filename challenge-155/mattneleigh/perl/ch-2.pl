#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 3;

printf(
    "\nThe Pisano period for %d is: %d\n\n",
    $n,
    pisano_period($n)
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the Pisano period (usually written as a lower-case pi...) of an
# integer N
# Takes one argument:
# * The integer N to examine, which must be greater than zero
# Returns on success:
# * The Pisano period for this integer
# Returns on error:
# * undef if the integer is not greater than zero
# NOTE: As Fibonacci numbers can get very large in very short order,
# 'use bigint' is required if N may be larger than 9
################################################################################
sub pisano_period{
    use bigint;

    my $n = int(shift());

    return(undef)
        if($n < 1);

    # Start with a few initial values
    my $a = 0;
    my $b = 1;
    my $str = "0" . 1 % $n;
    my $count = 1;

    while(1){
        # Return the iteration counter if we spot
        # a repeating pattern
        return($count)
            if($str =~ m/^(\d+)\1$/);

        # Calculate two more Fibonacci numbers and
        # add the remainders of division by $n to
        # the string
        for(1 .. 2){
            ($a, $b) = ($b, $a + $b);
            $str .= $b % $n;
        }

        # Increment the iteration counter- which
        # will be half the number of Fibonacci
        # numbers examined
        $count++;

    }

}



