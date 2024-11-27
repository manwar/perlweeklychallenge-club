#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "17893729974",
    "4137 8947 1175 5904",
    "4137 8974 1175 5904"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \"%s\"\nOutput: %s\n\n",
        $string,
        validate_checksum($string) ?
            "true"
            :
            "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string of digits and, optionally, other characters, determine whether
# the last digit contains a valid checksum for the rest of the set of digits,
# using the Luhn algorith
# See: https://en.wikipedia.org/wiki/Luhn_algorithm
# Takes one argument:
# * The string to examine (e.g. "17893729974" )
# Returns:
# * 0 if the checksum does not appear valid
# * 1 if the checksum appears valid (as it would be in the case of th example
#   above)
################################################################################
sub validate_checksum{
    my @digits = grep(/[0-9]/, split(//, shift()));

    my $digit;
    my $sum = 0;
    my $checksum = pop(@digits);

    # Loop over each pair of digits except the
    # checksum
    while(@digits){
        # Grab the current last digit and double it
        $digit = pop(@digits) * 2;

        # If that resulted in a two digit value, sum
        # THOSE digits
        if($digit > 9){
            $digit = substr($digit, 0, 1)
                +
                substr($digit, 1, 1);
        }

        # Add the result to the running total
        $sum += $digit;

        # If there's another digit left, grab it
        # and add it to the total as well
        $sum += pop(@digits)
            if(@digits);
    }

    return(
        # If the checksum plus the total is
        # evenly divisible by ten, the checksum
        # was valid
        !(($sum + $checksum) % 10)
    );

}



