#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @number_bases = (
    [ "101010",  2 ],
    [ "EEADEE", 16 ],
    [    "755",  8 ],
    [  "1BRJB", 36 ],
    [  "7MyqL", 64 ],
);
my @digits = (
    0 .. 9, "A" .. "Z", "a" .. "z", "+", "/"
);

print("\n");
foreach my $number_base (@number_bases){
    printf(
        "Input: \$num = \"%s\", \$base = %d\nOutput: %d\n\n",
        $number_base->[0],
        $number_base->[1],
        integer_from_digits_in_base(
            # Create the digit array for this base as a
            # slice from @digits
            [ @digits[0 .. $number_base->[1] - 1] ],
            $number_base->[0]
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string that represents a number written in a particular base, convert
# the string to an integer with the quivalent value
# Takes two arguments:
# * A ref to an array of digits in which the number-string is written, where
#   the index of the digit must correspond to its value (e.g.
#       [ "0", "1", "2", ... "9", "A", "B", "C", "D", "E", "F" ]
#   which implies conversion to hexadecimal (base-16))
# * The number-string encoded in the specified digit set (e.g. "EEADEE")
# Returns:
# * The value of the number represented by the specified string using the
#   specified digits (e.g. 15642094)
################################################################################
sub integer_from_digits_in_base{

    my $base = 0;

    # Make a lookup table for digit values
    my %base_digits = map(
        { $_ => $base++ }
        @{shift()}
    );
    my $number = shift();

    my $magnitude = 0;
    my $sum = 0;

    # Loop while unprocessed digits remain
    while(length($number)){
        # Accumulate the value of last remaining
        # digit multiplied by the base raised to the
        # power of the current order of magnitude,
        # then remove this digit
        $sum += $base_digits{substr($number, -1, 1, "")}
            *
            $base ** $magnitude++;
    }

    return($sum);

}



