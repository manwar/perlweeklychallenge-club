#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @numbers = (
    # Given cases
    56, 57, 59,

    # Additional test cases
    1500, 196
);
my $number;
my $iterations = 0;

print("\n");
foreach $number (@numbers){
    my $rval = is_lychrel_number($number, \$iterations);

    print("Input: \$n = $number\n");
    print("Output: ", defined($rval) ? $rval : "Invalid input", "\n");
    print(
        "After $iterations iteration",
        ($iterations == 1 ? "" : "s"),
        ", we found ",
        defined($rval)
        ?
        ($rval ? "no palindromes" : "a palindrome")
        :
        "that our input was not valid",
        ".\n\n"
    );
    $iterations = 0;
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a number appears to be a Lychrel number- a natural number
# that cannot form a palindrome through the iterative process of repeatedly
# reversing its digits and adding the resulting numbers.  To limit the use of
# computing resources, this function will declare an input value to be a
# probable Lychrel number if the running total exceeds 10000000 or more than
# 500 iterations have passed.  Input values are also restricted to those
# between 10 and 1000, inclusive.
# Takes two arguments:
# * A number N to evaluate
# * Optionally, a ref to a scalar that may be populated with the number of
#   iterations required to determine whether N appeared to be a Lychrel number
# Returns on success:
# * 0 if N does not appear to be a Lychrel number
# * 1 if N appears to be a Lychrel number
# Returns on error:
# * undef if N is less than 10 or more than 1000
################################################################################
sub is_lychrel_number{
    my $n = int(shift());
    my $iter = shift();

    $$iter = 0 if(defined($iter));

    # Establish a range of valid inputs
    return(undef) unless(($n > 9) && ($n < 1001));

    my $i = 0;
    my $reversed = 0;

    while($i <= 500){
        # Swap digits around and compare...
        $reversed = reverse(split("", $n));
        if($reversed == $n){
            # Found a palindrome- this is not a
            # Lychrel number
            $$iter = $i if(defined($iter));
            return(0);
        }

        # Add the reversed number to the total,
        # and bail if the number is too large
        $n += $reversed;
        last if($n >= 10000000);

        $i++;
    }

    # If we got here, either the total got
    # too large, or we ran out of
    # iterations; we'll assume this is a
    # Lychrel number
    $$iter = $i if(defined($iter));
    return(1);

}



