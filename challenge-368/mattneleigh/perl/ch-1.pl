#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @ints_and_digits = (
    # Given cases
    [ "15456",  "5" ],
    [ "7332",   "3" ],
    [ "2231",   "2" ],
    [ "543251", "5" ],
    [ "1921",   "1" ],

    # Additional test cases
    [ "243559", "8" ]
);

print("\n");
foreach my $int_and_digit (@ints_and_digits){
    printf(
        "Input: \$str = \"%s\", \$char = \"%s\"\nOutput: \"%s\"\n\n",
        $int_and_digit->[0],
        $int_and_digit->[1],
        largest_value_without_digit(@{$int_and_digit})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an integer and a digit to remove, remove the one instance of that digit
# that results in the largest number made up of the remaining digits; if the
# digit is not present in the number, the original number will be returned
# Takes two arguments:
# * The number to examine (e.g. 543251)
# * The digit to look for (e.g. 5)
# Returns:
# * The number after processing as described above (e.g. 54321)
################################################################################
sub largest_value_without_digit{
    my @digits = split('', shift());
    my $match_digit = shift();

    my $last_match = undef;

    # Loop over all digits
    for my $i (0 .. $#digits){
        if($digits[$i] == $match_digit){
            # This digit matched our search digit
            if(
                defined($digits[$i + 1])
                &&
                ($digits[$i + 1] > $match_digit)
            ){
                # There is a next digit and it is larger than
                # this one- remove this match and return the
                # resulting number
                splice(@digits, $i, 1);
                return(join("", @digits));
            }

            # The next digit must not exist or must be
            # smaller than this one- make a note of the
            # location of this match
            $last_match = $i;
        }
    }

    # If we got here, and if there were any
    # matches, remove the last match, as it has
    # the lowest value
    splice(@digits, $last_match, 1)
        if(defined($last_match));

    # Return the resulting number
    return(join("", @digits));
    
}



