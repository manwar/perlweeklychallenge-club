#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [  6,  2,  3,  3 ],
    [  3,  1,  4, 13 ],
    [  2,  1,  4,  2 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %s\n\n",
        join(", ", @{$integer_list}),
        contains_doubled_pair(@{$integer_list}) ?
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
# Given a list of integers, determine whether a pair is contained within such
# that one value is double the other
# Takes one argument:
# * The list of integers to examine (e.g. ( 6, 2, 3, 3 ) )
# Returns:
# * 0 if the list does not contain a pair in which one value is double the
#   other
# * 1 if the list contains a pair in which one value is double the other (as
#   would be the case in the example above)
################################################################################
sub contains_doubled_pair{

    my $i;
    my $j;

    # Loop over each possible pair $i, $j
    foreach $i (0 .. $#ARG - 1){
        foreach $j ($i + 1 .. $#ARG){
            # Skip ahead if the values at $i, $j don't
            # contain a pair where one is double the other
            # (we check for this relationship in both
            # directions as it was never specified that
            # $i < $j, just $i != $j)
            next
                unless(
                    ($ARG[$i] == 2 * $ARG[$j])
                    ||
                    ($ARG[$j] == 2 * $ARG[$i])
                );

            # We didn't skip?  A doubled pair has been
            # found
            return(1);
        }
    }

    # Got here?  Didn't find a doubled pair
    return(0);

}



