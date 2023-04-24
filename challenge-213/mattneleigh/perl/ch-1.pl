#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @lists = (
    [ 1, 2, 3, 4, 5, 6 ],
    [ 1, 2 ],
    [ 1 ]
);

print("\n");
foreach my $list (@lists){
    printf(
        "Input: \@list = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$list}),
        join(", ", fun_sort(@{$list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Sort a list of integers such that the even numbers, sorted in ascending
# order, appear before the odd numbers, which are also sorted in ascending
# order
# Takes one argument:
# * The list to examine (e.g. ( 1, 2, 3, 4, 5, 6 ) )
# Returns:
# * The specially sorted list (e.g. ( 2, 4, 6, 1, 3, 5 ) )
################################################################################
sub fun_sort{

    my @odds;
    my $i = 0;

    # Loop while $i is within @ARG- which
    # may be shrinking
    while($i <= $#ARG){
        if($ARG[$i] % 2){
            # Odd number- remove it and put it in
            # @odds
            push(@odds, splice(@ARG, $i, 1));
        } else{
            # Even number- move ahead
            $i++;
        }
    }

    # Sort both lists, combine, and return
    return(sort(@ARG), sort(@odds));

}



