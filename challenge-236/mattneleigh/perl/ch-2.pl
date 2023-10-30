#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    # Given cases
    [ 4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10 ],
    [ 0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19 ],
    [ 9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17 ],

    # Additional test case(s)
    [ 0, 1, 2, 3, 4, 5, 6, 22, 8 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        count_index_loops(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Count the index loops within an array of unique integers- that is to say, the
# number of instances in which treating each value at a given index as the next
# index in the sequence produces a loop
# Takes one argument:
# * An array of unique integers to examine (e.g. ( 0, 1, 13, 7, 6, 8, 10, 11,
#   2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19 ) )
# Returns:
# * The count of index loops (e.g. 6 )
################################################################################
sub count_index_loops{

    my %seen;
    my $loopct = 0;

    # Loop over @ARG
    for my $i (0 .. $#ARG){
        # Skip this $i if we've already seen it
        next
            if($seen{$i});

        my $j = $i;

        while(1){
            # Mark this $j as seen
            $seen{$j} = 1;

            # Jump to the next $j
            $j = $ARG[$j];

            unless(defined($j)){
                # $ARG[$j] was not in the array?  Break out
                # of this iteration but do NOT count this
                # as a loop
                last;
            }

            if($seen{$j}){
                # This $j has been seen; increment index loop
                # count and break out of this iteration
                $loopct++;
                last;
            }
        }        
    }

    return($loopct);

}



