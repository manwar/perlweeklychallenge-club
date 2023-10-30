#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 1, 2, 2, 2, 3 ],
    [ 2, 3, 1, 3, 2 ],
    [ -1, 1, -6, 4, 5, -6, 1, 4, 1 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOuput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", frequency_sort(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Sort a given array of integers in ascending order based on the frequency with
# which each appears in the array.  If multiple integer values have the same
# frequency, those values will be sorted amongst each other in descending
# order.
# Takes one argument:
# * The list of integers to examine (e.g. (-1, 1, -6, 4, 5, -6, 1, 4, 1) )
# Returns:
# * A list of the provided integers, sorted in the manner described above (e.g.
#   (5, -1, 4, 4, -6, -6, 1, 1, 1) )
################################################################################
sub frequency_sort{

    my %buckets;

    while(@ARG){
        my $int = shift();

        # Remove each int from the arg list and add it
        # to its bucket; this will autovivify if the
        # int hasn't been seen before
        push(@{$buckets{$int}}, $int);
    }

    return(
        # Make one list out of the contents of the
        # buckets once they're sorted in the specified
        # order
        map(
            @{$buckets{$_}},
            sort(
                {
                    scalar(@{$buckets{$a}}) == scalar(@{$buckets{$b}}) ?
                        ($b <=> $a)
                        :
                        (scalar(@{$buckets{$a}}) <=> scalar(@{$buckets{$b}}));
                }
                keys(%buckets)
            )
        )
    );

}



