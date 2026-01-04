#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 4, 2, 1, 3 ],
    [ 10, 100, 20, 30 ],
    [ -5, -2, 0, 3 ],
    [ 8, 1, 15, 3 ],
    [ 12, 5, 9, 1, 15 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints= (%s)\nOutput: %s\n\n",
        join(", ", @{$integer_list}),
        join(
            ", ",
            map(
                "[ " . join(", ", @{$_}) . " ]",
                find_min_abs_diff_pairs(@{$integer_list})
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array @a of distinct integers, find all pairs of elements that share
# the same minimum absolute difference- that is to say, all pairs $i, $j such
# that $i != $j and abs($a[$i] - $a[$j]) which share the same minimum value
# Takes one argument:
# * The array of integers to examine (e.g. ( 4, 2, 1, 3 ) )
# Returns:
# * A list of pairs of integers that share the same minimum absolute difference
#   (e.g. ([ 1, 2 ], [ 2, 3 ], [ 3, 4 ]) )
################################################################################
sub find_min_abs_diff_pairs{
    use List::Util qw(min);

    my $diff;
    my %diffs;

    # Loop over all pairs within the list
    for my $i (0 .. $#ARG - 1){
        for my $j ($i + 1 .. $#ARG){
            $diff = $ARG[$i] - $ARG[$j];

            # Store this pair in a list within the %diffs hash,
            # the absolute difference between them being used as
            # the key
            push(
                @{$diffs{abs($diff)}},
                # Order values within the pair to match the sample
                # output
                $diff < 0 ?
                    [ $ARG[$i], $ARG[$j] ]
                    :
                    [ $ARG[$j], $ARG[$i] ]
            );
        }
    }

    return(
        # Sort the list so it matches the sample output
        sort(
            { $a->[0] <=> $b->[0] }
            # Get the list of pairs associated with the minimum
            # difference used as a key in the hash
            @{$diffs{min(keys(%diffs))}}
        )
    );

}



