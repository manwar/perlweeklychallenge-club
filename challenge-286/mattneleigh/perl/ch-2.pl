#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 2, 1, 4, 5, 6, 3, 0, 2 ],
    [ 0, 5, 3, 2 ],
    [ 9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        order_game(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers that has a number of elements that is a power of
# two, perform the Order Game on the list until there is only one element
# remaining, i.e. each pair within the list is alternately replaced with its
# min or max, in successive iterations until only one element remains, which is
# returned
# Takes one argument:
# * The list of integers to examine (e.g. ( 2, 1, 4, 5, 6, 3, 0, 2 ) )
# Returns:
# * The remaining integer after all operations are complete (e.g. 1 )
################################################################################
sub order_game{
    use List::Util qw(min max);

    my @list = @ARG;

    # Loop while there are more than one elements
    # in the list
    while(scalar(@list) > 1){
        my $step = 0;

        # Work our way through the list- which will
        # be shrinking
        while($step < $#list){
            # Insert the min or max of the next pair
            # (already removed from the list) into the
            # spot previously occupied by said pair
            splice(
                @list,
                $step,
                0, 
                $step % 2 ?
                    # Odd step- take the max of the next pair,
                    # having removed them from the list
                    max(splice(@list, $step, 2))
                    :
                    # Even step- take the min of the next pair,
                    # having removed them from the list
                    min(splice(@list, $step, 2))
            );
            $step++;
        }
    }

    # The remaining element in the list is the
    # desired output
    return($list[0]);

}



