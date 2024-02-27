#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 5, 2, 1, 6 ],
    [ 1, 2, 0, 3 ],
    [ 0, 1 ],
    [ 9, 4, 9, 2 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", determine_ordinal_rank(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an list of integers, determine the ordinal rank of each- that is to
# say, count how many in the list are smaller than each individual integer
# Takes one argument:
# * The list of integers to examine (e.g. ( 5, 2, 1, 6 ) )
# Returns:
# * A list of ordinal ranks of each integer (e.g. ( 2, 1, 0, 3 ) )
################################################################################
sub determine_ordinal_rank{
    use List::MoreUtils qw(uniq);

    my $rank = 0;

    # Build a table with the unique input integers as
    # keys and their relative ordinal rank as values
    my %rank_table = map(
        { $_ => $rank++ }
        uniq(sort({ $a <=> $b } @ARG))
    );

    return(
        # Make a list of the ordinal ranks of each given
        # integer
        map(
            $rank_table{$_},
            @ARG
        )
    );

}



