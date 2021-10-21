#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @numbers = (
    # Given test cases
    1234567,
    -123,
    1,
    10,

    # Additional test cases
    -626.4537,
    "Six and a half"
);
my $number;

foreach $number (@numbers){
    print("Input: \$n = $number\n");
    print("Output: ", middle_three_digits($number), "\n\n\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Get the middle three digits from a number, regardless of where they might
# appear relative to any negative signs or decimal places
# Takes one argument:
# * The number to process
# Returns on success:
# * The middle three digits of the number
# Returns on error:
# * A message describing the problem with an invalid number
################################################################################
sub middle_three_digits{
    my $number = shift();

    my $length;

    # Get rid of any leading negative sign
    # or dicemal point, and find the length
    # of the number
    $number =~ s/^-//;
    $number =~ s/\.//;
    $length = length($number);

    # Return specific messages if the
    # number isn't one we can process
    # further
    return("Not a number") if($number =~ m/\D/);
    return("Even number of digits") unless($length % 2);
    return("Too short") unless($length > 2);

    # Extract and return the middle
    # three digits
    return(
        substr($number, int($length / 2) - 1, 3)
    );

}



