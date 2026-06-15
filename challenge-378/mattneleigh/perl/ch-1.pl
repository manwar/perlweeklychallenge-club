#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "aaaaa77777",
    "abcde",
    "9zero8eight7seven9",
    "xyz9876543210",
    "4abc4def2ghi8jkl2"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %d\n\n",
        $string,
        find_second_largest_digit($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an alphanumeric string, find the second largest distinct digit therein,
# if any
# Takes one argument:
# * The string to examine (e.g. "9zero8eight7seven9")
# Returns:
# * The second largest distinct digit, if present (e.g. 8)
# * -1 if there is no second largest distinct digit
################################################################################
sub find_second_largest_digit{

    # Make a table of digits seen within the
    # string
    my %digits = map(
        { $_ => 1 }
        grep(/\d/, split("", shift()))
    );

    # Sort the extracted digits in ascending
    # order, then attempt to store the second to
    # last one
    my $digit = (sort(keys(%digits)))[-2];

    # Return the digit we found, if indeed we
    # found one at all, or return -1
    return(
        defined($digit) ?
            $digit
            :
            -1
    );

}



