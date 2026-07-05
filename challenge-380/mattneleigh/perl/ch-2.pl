#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "z",
    "a",
    "bbc",
    "racecar",
    "zyx"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %d\n\n",
        $string,
        calculate_reverse_degree($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, calculate its Reverse Order- that is to say the sum of the
# values of each character's position in a reversed alphabet (i.e.  a = 26, b =
# 25, ...  y = 2, z = 1) multiplied by its position within the string, one-
# indexed.
# Takes one argument:
# * The string to examine (e.g "racecar")
# Returns:
# * The Reverse Degree of the specified string (e.g. 560)
################################################################################
sub calculate_reverse_degree{
    my $string = lc(shift());

    my $pos = 0;
    my $sum = 0;

    # Loop over each position within the string
    while($pos < length($string)){
        # Accumulate the value of this letter's
        # reverse degree, incrementing the position
        # en passant
        $sum += (26 - (ord(substr($string, $pos, 1)) - 97)) * ++$pos;
    }

    return($sum);

}



