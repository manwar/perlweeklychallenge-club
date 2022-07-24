#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @lists = (
    [ 1, 0, 2 ],
    [ 0, 1, 2 ]
);
my $rank = 1;


print("\n");
printf(
    "permutation2rank([%s]) = %d\n",
    join(", ", @{$lists[0]}),
    permutation2rank(@{$lists[0]})
);
print("\n");
printf(
    "rank2permutation([%s], %d) = [%s]\n",
    join(", ", @{$lists[1]}),
    $rank,
    join(", ", rank2permutation($lists[1], $rank)),
);
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the rank of a permutation of unique consecutive integers starting
# with 0, as specified in lexicographic order (e.g. ( 0, 1, 2 ), ( 0, 2, 1 ),
# etc.)
# Takes one argument:
# * The permutation to examine, as a list of digits (e.g. ( 1, 0, 2 ) )
# Returns:
# * The lexicographic rank of the specified permutation, starting with 0 (e.g.
#   2 )
# Translated from the Python equivalent at:
# https://tryalgo.org/en/permutations/2016/09/05/permutation-rank/
################################################################################
sub permutation2rank{
    use POSIX;

    my $i;
    my $n = scalar(@ARG);
    my $factorial = 1;

    # A pool of all possible digits for a list
    # of the given size
    my @digits = (0 .. $n - 1);

    my $rank = 0;

    # Calculate ($n - 1)!
    for $i (2 .. $n - 1){
        $factorial *= $i;
    }

    # Loop over all digits but the last
    for $i (0 .. $n - 2){
        my $q = $digits[$ARG[$i]];

        $rank += $factorial * $q;

        # Remove the examined digit from the pool
        splice(@digits, $q, 1);

        # Calculate the weight of the next digit
        $factorial = floor($factorial / ($n - 1 - $i));
    }

    return($rank);

}



################################################################################
# Produce the permutation of specified rank from a series of permutations, in
# lexicographic order, of a list of unique consecutive integers starting with 0
# (e.g. ( 0, 1, 2 ), ( 0, 2, 1 ), etc.)
# Takes two arguments:
# * A ref to a list of integers- this is exclusively used to calculate the
#   upper bound of values to be found within the list (e.g. [ 0, 1, 2 ] )
# * The desired rank, with ranks beginning at 0 (e.g. 1 )
# Returns:
# * A list of digits corresponding to the permutation of the specified rank
#   (e.g. ( 0, 2, 1 ) )
# Translated from the Python equivalent at:
# https://tryalgo.org/en/permutations/2016/09/05/permutation-rank/
################################################################################
sub rank2permutation{
    use POSIX;

    my $n = scalar(@{shift()});
    my $rank = int(shift());

    my $i;
    my $factorial = 1;

    # A pool of all possible digits for a list
    # of the given size
    my @digits = (0 .. $n - 1);

    my @permutation;

    # Calculate ($n - 1)!
    for $i (2 .. $n - 1){
        $factorial *= $i;
    }


    for $i (0 .. $n - 1){
        my $q = floor($rank / $factorial);

        $rank %= $factorial;

        # Add the digit to the list and remove
        # the used digit from the pool
        push(@permutation, $digits[$q]);
        splice(@digits, $q, 1);

        if($i != ($n - 1)){
            # Calculate the weight of the next digit
            $factorial = floor($factorial / ($n - 1 - $i));
        }
    }

    return(@permutation);

}



