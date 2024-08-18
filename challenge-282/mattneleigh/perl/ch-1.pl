#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @ints = (
    12344456,
    1233334,
    10020003
);

print("\n");
foreach my $int (@ints){
    printf(
        "Input: \$int = %d\nOutput: \"%s\"\n\n",
        $int,
        find_good_digit($int)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a positive integer with three or more digits, find the first Good
# Integer within- that is, a block of exactly three repeating digits
# Takes one argument:
# * The positive integer to examine (e.g. 12344456 )
# Returns on success
# * The first Good Integer found within the number (e.g. 444 )
# Returns on failure
# * -1 if there was no Good Integer within the number
################################################################################
sub find_good_digit{

    my $prev_digit = "";
    my $count = 1;

    # Loop over each digit
    foreach my $digit (split(//, shift())){
        if($digit eq $prev_digit){
            # This digit matches the previous digit-
            # increment the count
            $count++;
        } else{
            # This digit does not match the previous
            # digit- if the count for the previus digit
            # was 3, return a block of three of that
            # digit
            return($prev_digit x 3)
                if($count == 3);

            # Store the new digit and reset the
            # count
            $prev_digit = $digit;
            $count = 1;
        }
    }

    # If we got here, there was no Good Integer
    return(-1);

}



