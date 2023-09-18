#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 4, 4, 2, 4, 3 ],
    [ 1, 1, 1, 1, 1 ],
    [ 4, 7, 1, 10, 7, 4, 1, 1 ]
);

print("\n");
foreach my $interger_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOuput: %d\n\n",
        join(", ", @{$interger_list}),
        count_unequal_triplets(@{$interger_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine how many unequal triplets exist within a list of integers (i.e.
# count the sets ($list[$i], $list[$j], $list[$k]) such that $list[$i] !=
# $list[$j] != $list[$k] ).  Note that all examined triplets will occur in
# their original order within the list (i.e. $i < $j < $k ).
# Takes one argument:
# * A list of integers to examine (e.g. ( 4, 7, 1, 10, 7, 4, 1, 1 ) )
# Returns on success:
# * The count of unequal triplets within the list (e.g. 28 )
# Returns on error:
# * undef if there are not at least three elements in the list
################################################################################
sub count_unequal_triplets{

    my $count = 0;

    return(undef)
        if(scalar(@ARG) < 3);

    # Loop over all $i, $j, $k such that
    # $i < $j < $k
    for my $i (0 .. $#ARG - 2){
        for my $j ($i + 1 .. $#ARG - 1){
            for my $k ($j + 1 .. $#ARG){
                # Increment the count if the values in
                # @ARG at these $i, $j, $k are not equal
                $count++
                    unless(
                        ($ARG[$i] == $ARG[$j])
                        ||
                        ($ARG[$j] == $ARG[$k])
                        ||
                        ($ARG[$k] == $ARG[$i])
                    );
            }
        }
    }

    return($count);

}



