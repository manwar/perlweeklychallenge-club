#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    # Given cases
    [ 1, 2, 2, 4 ],
    [ 1, 2, 3, 4 ],
    [ 1, 2, 3, 3 ],

    # Additional test cases
    [ 1, 1, 3, 4 ],
    [ 1, 1, 2, 3 ],
    [ 1, 3, 3, 4 ],
    [ 1, 2, 4, 4 ]
);

print("\n");
foreach my $list (@integer_lists){
    my $result = find_duplicate_and_missing(@{$list});

    if(defined($result)){
        # $result is defined- stringify the
        # contents pointed to by the returned
        # array ref
        $result = sprintf("(%s)", join(", ", @{$result}));
    } else{
        # $result is undefined- set it to -1
        $result = -1;
    }

    printf(
        "Input: \@nums = (%s)\nOutput: %s\n\n",
        join(", ", @{$list}),
        $result
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find a duplicate and missing integer in a sequence of otherwise-consecutive
# integers in ascending order
# Takes one argument:
# * A list of integers, in ascending order, to examine (e.g. ( 1, 2, 2, 4 ) )
# Returns:
# * A ref to a list containing the duplicate number, and the missing number
#   (e.g. [ 2, 3 ] )  Note that the missing number may be the one before or
#   after the duplicate, in ordinal sequence, depending on the contents of the
#   supplied list
# - OR -
# * undef if no duplicate was found in the list
################################################################################
sub find_duplicate_and_missing{

    for my $i (0 .. ($#ARG - 1)){
        if($ARG[$i] == $ARG[$i + 1]){
            # We have a duplicate...
            if($i == 0){
                # ...at the start of the list; return
                # the value in cell 0 and either the
                # preceeding or succeeding would-be
                # value, depending on which looks to
                # be missing
                return(
                    [
                        $ARG[0],
                        (
                            $ARG[2] == ($ARG[0] + 2) ?
                            $ARG[0] + 1
                            :
                            $ARG[0] - 1
                        )
                    ]
                );
            } else{
                # ...somewhere in the middle or
                # the end of the list; return the
                # value in cell $i and either the
                # preceeding or succeeding would-be
                # value, depending on which looks to
                # be missing
                return(
                    [
                        $ARG[$i],
                        (
                            $ARG[$i - 1] == ($ARG[$i] - 1) ?
                            $ARG[$i] + 1
                            :
                            $ARG[$i] - 1
                        )
                    ]
                );
            }
        }
    }

    # We didn't find a duplicate
    return(undef);

}



