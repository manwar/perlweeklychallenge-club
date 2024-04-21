#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    # Given cases
    [ 1, 2, 3, 3, 3, 3, 4, 2 ],
    [ 1, 1 ],
    [ 1, 2, 3 ],

    # Additional test case(s)
    [ 1, 2, 3, 4, 5, 6, 7, 8 ]    
);

print("\n");
foreach my $integer_list (@integer_lists){
    my $found_number = lowest_over_33(@{$integer_list});

    printf(
        "Input: \@ints = (%s)\nOutput: %s\n\n",
        join(", ", @{$integer_list}),
        defined($found_number) ? $found_number : "undef"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find the lowest value, if any, that appears in an array of integers at least
# 33% of the time
# Takes one argument:
# * The array to examine (e.g. ( 1, 2, 3 ) )
# Returns:
# * The lowest value that appeared in at least 33% of the cells of the array,
#   or undef if no such value was found (e.g. 1 )
################################################################################
sub lowest_over_33{

    my %frequency;

    # Count how many times each number
    # appears in the list
    foreach my $num (@ARG){
        $frequency{$num}++;
    }

    return(
        # Capture the first (lowest) number in a
        # sorted list of instances that were
        # seen at least 33% of the time; this
        # will be undef if no matching numbers
        # were found
        (
            sort(
                { $a <=> $b }
                # Build a list of numbers that were seen
                # at least 33% of the time
                map(
                    $frequency{$_} / scalar(@ARG) >= 0.33 ?
                        $_
                        :
                        (),
                    keys(%frequency)
                )
            )
        )[0]
    );

}



