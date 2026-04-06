#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @binary_numbers = (
    # Given cases
    "1011",
    "100",
    "111000",
    "0101",
    "1111",

    # Additional test cases
    "0000"
);

print("\n");
foreach my $binary_number (@binary_numbers){
    printf(
        "Input: \$str = \"%s\"\nOutput: \"%s\"\n\n",
        $binary_number,
        maximum_odd_binary($binary_number)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string that consists of ones (1) and zeros (0) only, rearrange them
# to express the largest possible odd value that can be formed using the given
# binary digits
# Takes one argument:
# * A string consisting solely of ones and zeros (e.g. "1011")
# Returns:
# * A string constructed from the binary digits from the supplied string,
#   rearranged to form the largest odd value possible (e.g. "1101")
################################################################################
sub maximum_odd_binary{
    my @bits = split("", shift());

    # Sort bits so the 1's come first
    @bits = sort({ $b <=> $a } @bits);

    # Loop over the bits in newly-sorted order
    for my $i (0 .. $#bits - 1){
        unless($bits[$i + 1]){
            # The next bit is a zero- swap the current
            # bit with the last bit and break out of the
            # loop
            ($bits[$i], $bits[-1]) = ($bits[-1], $bits[$i]);
            last;
        }
    }

    return(join("", @bits));

}



