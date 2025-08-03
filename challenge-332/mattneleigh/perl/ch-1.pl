#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @dates = (
    "2025-07-26",
    "2000-02-02",
    "2024-12-31"
);

print("\n");
foreach my $date (@dates){
    printf(
        "Input: \$date = \"%s\"\nOutput: \"%s\"\n\n",
        $date,
        date_to_binary($date)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Convert a date in YYYY-MM-DD format to an equivalent binary representation in
# which the year, month, and day have all been converted to a binary
# representation consisting of ones and zeros
# Takes one argument:
# * A string containing the date to convert (e.g. "2025-07-26")
# Returns:
# * A string containing the supplied date represented in binary as a series of
#   ones and zeros (e.g. "11111101001-111-11010")
################################################################################
sub date_to_binary{

    # Split the date into numbers, process them into binary,
    # recombine them into a new date, and return
    return(
        sprintf(
            "%b-%b-%b",
            split(/-/, shift())
        )
    );

}



