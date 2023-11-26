#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 8, 1, 2, 2, 3 ],
    [ 6, 5, 4, 8 ],
    [ 2, 2, 2 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@int = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", count_smaller_members(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Count the number of elements in a list of integers that are smaller than each
# individual member in the list
# Takes one argument:
# * A list of integers (e.g. ( 8, 1, 2, 2, 3 ) )
# Returns:
# * A list of counts of members in the supplied list that are smaller than the
#   corresponding member of the original list (e.g. ( 4, 0, 1, 1, 3 ) )
################################################################################
sub count_smaller_members{

    # Make a copy of the arguments, sorted in
    # ascending order
    my @sorted = sort({ $a <=> $b } @ARG);

    return(
        map(
            # Run on each member of the original
            # list; returns each member's count of
            # numbers smaller than itself
            {
                my $count = 0;

                # Loop over the sorted numbers
                for my $num (@sorted){
                    # Break out of the loop unless this
                    # sorted member is smaller than the one
                    # being examined; otherwise increment
                    # the count
                    last
                        unless($num < $_);
                    $count++;
                }

                $count;
            }
            @ARG
        )
    );

}



