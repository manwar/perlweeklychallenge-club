#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 6, 12, 25, 1 ],
    [ 10, 7, 31, 5, 2, 2 ],
    [ 1, 2, 10 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        calculate_concatenation_value(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an list of positive integers, calculate the concatenation value of all
# the integers therein.  This is accomplished by removing the first and last
# value from the list, concatenating them, and adding the resulting value to
# the running total; this cycle continues until until no integers remain in the
# list.
# Takes one argument:
# * A list of positive integers (e.g. ( 10, 7, 31, 5, 2, 2 ) )
# Returns:
# * The concatenation value of the provided integers (e.g. 489 )
################################################################################
sub calculate_concatenation_value{

    my $sum = 0;

    # Loop while there are numbers to process
    while(@ARG){
        if(scalar(@ARG) == 1){
            # One number left; add it to the total
            $sum += shift(@ARG);
        } else{
            # Two or more numbers left; concatenate
            # the first and last, and add the result
            # to the total
            $sum += shift(@ARG) . pop(@ARG);
        }
    }

    return($sum);

}



