#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integers = (
    # Given cases
    123,
    1234,
    1000000,
    1,
    12345,

    # Additional test cases
    100000000
);

print("\n");
foreach my $integer (@integers){
    printf(
        "Input: \$int = %d\nOutput: \"%s\"\n\n",
        $integer,
        insert_thousand_separators($integer)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a positive integer, add commas to separate blocks of digits by powers
# of 1000
# Takes one argument:
# * The integer to process (e.g. 1000000)
# Returns:
# * A string representing the integer with comma separators added (e.g.
#   "1,000,000")
################################################################################
sub insert_thousand_separators{
    my $int = shift();

    # If there's no work to do, just hand the int back
    return($int)
        if(length($int) < 4);

    my $offset = -3;

    # Skip back from the end of the string, adding commas
    # as necessary
    while(length($int) + $offset > 0){
        substr($int, $offset, 0, ",");

        # Decrement by 4 because we skip backward for another
        # thousands block AND the comma we just added
        $offset -= 4;
    }

    return($int);

}



