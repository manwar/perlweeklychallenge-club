#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 2, 1, 0 ],
    [ 0, 3, 0 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOuput: %s\n\n",
        join(", ", @{$integer_list}),
        verify_index_quantity_correlation(@{$integer_list}) ?
            "true"
            :
            "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of positive integers, determine wherther the value of each
# index $i appears within the array a number of times equal to the value stored
# in the array at that index
# Takes one argument:
# * The list of digits eo examine (e.g. (1, 2, 1, 0) )
# Returns:
# * 0 if any digit did not appear in the expected quantity
# * 1 if all digits appeared in the expected quantity, as would be the case for
#   the example above, for 0 appears 1 time, 1 appears 2 times, 2 appears 1
#   time, and 3 appears 0 times.
################################################################################
sub verify_index_quantity_correlation{

    my %frequency_table;

    # Build a frequency table, counting instances
    # of each digit
    foreach my $digit (@ARG){
        $frequency_table{$digit}++
    }

    # Loop over each index in the given array
    foreach my $i (0 .. $#ARG){
        # Return zero if the frequency count for this
        # index does not match the array value at
        # this index
        return(0)
            unless(
                # Digits we never saw get an effective count
                # of 0
                defined($frequency_table{$i}) ?
                    $frequency_table{$i}
                    :
                    0
                ==
                $ARG[$i]
            );
    }

    # Got here- every digit occurred in the
    # correct quantity
    return(1);

}



