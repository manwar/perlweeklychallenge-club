#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @numbers_bases = (
    [        42,  2 ],
    [  15642094, 16 ],
    [       493,  8 ],
    [   2228519, 36 ],
    [ 123456789, 64 ]
);
my @digits = (
    0 .. 9, "A" .. "Z", "a" .. "z", "+", "/"
);

print("\n");
foreach my $number_base (@numbers_bases){
    printf(
        "Input: \$num = %d, \$base = %d\nOutput: %s\n\n",
        $number_base->[0],
        $number_base->[1],
        convert_number_to_base(
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
# Given a list of digits in a numerical base, and a number to represent in that
# base, produce a string that represents the number in the specified base using
# the provided digits
# Takes two arguments:
# * A ref to an array of digits to use, in which the index of the digit must
#   correspond to its value (e.g.
#       [ "0", "1", "2", ... "9", "A", "B", "C", "D", "E", "F" ]
#   which implies conversion to hexadecimal (base-16))
# * The number to represent (e.g. 15642094)
# Returns on success:
# * A string representing the provided number in the base implied by the
#   supplied digits (e.g. "EEADEE" )
# Returns on error:
# * undef if the effective nummerical base is not at least 2 
################################################################################
sub convert_number_to_base{
    my $digits = shift();
    my $number = shift();

    my $base = @{$digits};

    # A sanity check and a shortcut
    return(undef)
        if($base < 2);
    return("0")
        if($number == 0);

    my $remainder;
    my $digit_string = "";

    # Loop while the number still contains a
    # nonzero value
    while($number){
        # Calculate each digit in the new base, and
        # add it to the digit string in ascending
        # order of magnitude
        $remainder = $number % $base;
        $number -= $remainder;
        $number /= $base;
        $digit_string .= $digits->[$remainder];
    }

    # Reverse the order of digits in the string
    # so they're in descending order
    return(scalar(reverse($digit_string)));

}



