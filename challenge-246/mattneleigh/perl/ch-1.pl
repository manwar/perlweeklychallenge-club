#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

print("\n");
for(1 .. 5){
    printf(
        "Ausgabe: \@lottozahlen = %s\n",
        join(
            ", ",
            map(
                sprintf("%2d", $_),
                sechs_von_neunundvierzig()
            )
        )
    );
}
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Generate six unique random integers in the range of 1 to 49, inclusive, for
# use in the German lottery.
# Takes no arguments.
# Returns:
# * A list of six unique random integers in the range of 1 to 49, inclusive,
#   sorted in ascending order (e.g. ( 1, 12, 15, 36, 42, 49 ) )
################################################################################
sub sechs_von_neunundvierzig{

    # A pool of numbers from which to select;
    # this will also serve as a table of numbers
    # not yet selected
    my @numbers = (1 .. 49);

    return(
        # 3: Sort the list of selected numbers in
        # ascending order
        sort(
            { $a <=> $b }
            # 2: Make a list of six numbers randomly
            # selected from the pool
            map(
                # 1: Randomly select- and remove- a number
                # from the pool
                splice(@numbers, int(rand(scalar(@numbers))), 1),
                1 .. 6
            )
        )
    );

}



