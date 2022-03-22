#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @numbers = (
    # Given cases
    7, 6, 8,

    # Additional test cases
    89, 1000, 131101
);
my $n;

print("\n");
foreach $n (@numbers){
    my $result = is_brazilian_number($n);

    printf(
        "Input: \$n = %d\nOutput: %s\n\n",
        $n,
        defined($result) ? $result : "UNDEFINED"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine if an integer N is a Brazilian number- it has a representation in
# a base B (such that 1 < B < N-1) in which all its digits are the same.  N
# must be 4 or larger.
# Takes one argument:
# * The integer N to examine, which must be at least 4
# Returns on success:
# * 1 if N is a Brazilian number
# * 0 if N is not a Brazilian number
# Returns on error:
# * undef if N is less than 4
################################################################################
sub is_brazilian_number{
    my $n = int(shift());

    # 1 < $b < ($n - 1) cannot be true unless
    # $n > 3
    return(undef)
        unless($n > 3);

    # Loop over the appropriate range for $b
    for my $b (2 .. ($n - 2)){
        my @digits = number_to_digit_list($n, $b);
        my $match = 1;

        # Loop over the "digits" to see if
        # they're all equal
        foreach(@digits){
            if($ARG != $digits[0]){
                $match = 0;
                last;
            }
        }

        # Return if the "digit" list only
        # contains the same value, repeated
        return(1)
            if($match);

    }

    # If we got here, we did not find a
    # representation that matched search
    # criteria
    return(0);

}



################################################################################
# Convert a computer-friendly number into a list of virtual digits in a
# specified base of 2 or larger; these virtual digits represent the numerical
# values of the digits in the given base, not the actual digits themselves, so
# the caller must devise a written representation of the values involved, if
# necessary
# Takes two arguments:
# * The number to convert to a list of virtual digits (e.g. 255)
# * The base in which the number should be written, which must be at least 2
# Returns on success:
# * A list of integers representing the values of the digits of the number's
#   representation in the specified base (e.g. (15, 15))
# Returns on error:
# * undef if the base is out of range
################################################################################
sub number_to_digit_list{
    my $number = int(shift());
    my $base = int(shift());

    return(undef)
        if($base < 2);

    my @digits;

    # Special case of the number being zero
    if($number == 0){
        return((0));
    }

    # Not zero- repeatedly convert remainders to
    # "digits" then truncate the dividend...
    while($number){
        unshift(@digits, $number % $base);
        $number = int($number / $base);
    }

    return(@digits);

}



