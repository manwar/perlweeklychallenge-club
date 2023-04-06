#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    # Given cases
    [ 2, 3, 1 ],
    [ 1, 1, 2, 2, 2, 3 ],

    # Additional test cases
    [ 1, 1, 2, 2, 2, 2, 2, 2, 3, 4 ],
    [ 1, 1, 1, 5, 5, 5, 5, 6, 7, 8 ],
    [ 1, 1, 5, 5, 5, 5, 7, 7, 7, 9 ],
);

print("\n");
foreach my $list (@integer_lists){
    printf(
        "Input: \@int = (%s)\nOutput: %d\nAfter deletions: (%s)\n\n",
        join(", ", @{$list}),
        maximum_deletion_score($list),
        join(", ", @{$list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Delete integers from a list, so as to maximize the sum of the integers
# removed.  All instances of one integer, all instances of that integer minus
# one, if present, and all instances of that integer plus one, if present,
# will be removed (e.g. 3, 2, and 4, respectively).
# Takes one argument:
# * A ref to the list of integers to process (e.g.
#   [ 1, 1, 2, 2, 2, 2, 2, 2, 3, 4 ] )
# Returns:
# * The total of all the integers removed from the list (e.g. 19 as 3 would be
#   chosen as the number to delete, as well as 2 and 4)
# NOTE: THE LIST WILL BE MODIFIED AS APPROPRIATE INTEGERS ARE DELETED FROM IT;
# the list need not be sorted when provided, but will be sorted after deletions
# are complete (e.g. the list above will be reduced to [ 1, 1 ] )
################################################################################
sub maximum_deletion_score{
    use List::Util qw(min max);

    my $n;
    my %subtotals;
    my $selection;
    my $max_total = 0;

    # Use each integer as a key in the subtotals
    # hash, adding up the sum of all instances of
    # each 
    while(defined($n = shift(@{$ARG[0]}))){
        if(defined($subtotals{$n})){
            $subtotals{$n} += $n;
        } else{
            $subtotals{$n} = $n;
        }
    }

    # Loop over the observed integers, to find the
    # maximum of the totals of each number AND the
    # values one above and one below, if present
    for $n (keys(%subtotals)){
        my $total = (
            (defined($subtotals{$n}) ? $subtotals{$n}  : 0)
            +
            (defined($subtotals{$n - 1}) ? $subtotals{$n - 1}  : 0)
            +
            (defined($subtotals{$n + 1}) ? $subtotals{$n + 1}  : 0)
        );

        if($total > $max_total){
            $selection = $n;
            $max_total = $total;
        }
    }

    # Delete our selected value and the values one
    # above and one below from the set of observed
    # integers
    for $n ($selection - 1 .. $selection + 1){
        delete($subtotals{$n});
    }

    # Replace the original list with one made up
    # only of the remaining integers- in the
    # correct quantities originally observed
    foreach $n (sort(keys(%subtotals))){
        push(
            @{$ARG[0]},
            map($n, (1 .. ($subtotals{$n} / $n)))
        );
        delete($subtotals{$n});
    }

    return($max_total);

}



