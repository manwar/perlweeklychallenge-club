#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_sets = (
    [ 8, 1, 9 ],
    [ 8, 6, 7, 1, 0 ],
    [ 1 ]
);

print("\n");
foreach my $integer_set (@integer_sets){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_set}),
        find_max_divisible_permutation(3, @{$integer_set})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the largest number that can be formed by concatenating some
# quantity of integers that are greater than or equal to zero, in any order,
# but which is also evenly divisible by a given integer divisor.
# Takes two arguments:
# * The integer divisor (e.g. 3)
# * A list of integers greater than or equal to zero (e.g.
#   ( 8, 6, 7, 1, 0 ) )
# Returns on success
# * The largest number that can be made from the digits in the list that is
#   also divisible by the specified divisor, if such a number can be
#   constructed (e.g. 8760 )
# - OR -
# * -1 if such a number cannot be constructed
################################################################################
sub find_max_divisible_permutation{
    my $divisor = shift();

    my $max = -1;

    # Loop over each combination of digits
    for my $combination (combinations(@ARG)){
        # Skip the empty list that combinations() can
        # return (see its documentation)
        next
            unless(@{$combination});

        my $permutations = [];

        # Generate permutations for this
        # combination
        permutations($permutations, $combination);

        # Loop over each permutation within this
        # combination
        for my $permutation (@$permutations){
            # Combine the digits from this permutation
            my $num = join("", @{$permutation});

            # Strip leading zeros, if any, so numbers
            # don't get interpreted as octals
            $num =~ s/^0+//;

            # Skip cases in which the number has no
            # digits left after removing zeros
            next
                unless(length($num));

            # Update the maximum if this number is
            # bigger and divisible by the divisor
            $max = $num
                if(($num > $max) && !($num % $divisor));
        }
    }

    return($max);

}



################################################################################
# Given a list of N integers, provides a list of all possible combinations of
# M integers, for all M where 0 <= M <= N
# Takes one argument:
# * A list of integers (e.g. (2, 1, 4) )
# Returns:
# * A list of all possible combinations of M integers, including where M equals
#   zero (e.g.
#       (
#           [ ],
#           [ 2 ],
#           [ 1 ],
#           [ 2, 1 ],
#           [ 4 ],
#           [ 2, 4 ],
#           [ 1, 4 ],
#           [ 2, 1, 4 ]
#       )
#   )
#
# NOTE: Translated and adapted from a Python solution found in the comments at:
# https://stackoverflow.com/questions/464864/get-all-possible-2n-combinations-of-a-list-s-elements-of-any-length
################################################################################
sub combinations{

    return([])
        unless(scalar(@ARG));

    my @cs;

    for my $c (combinations(@ARG[1 .. $#ARG])){
        push(@cs, [ @{$c} ], [ $ARG[0], @{$c} ]);
    }

    return(@cs);

}



################################################################################
# Generate all possible permutations of a given list
# Takes two arguments:
# * A ref to an empty array, which will be populated with a list of
#   permutations of the original list
# * A ref to an array whose permutations are desired
# Returns no meaningful value
# NOTE: Adapted from a solution found at:
# https://www.perlmonks.org/?node_id=1186402
################################################################################
sub permutations{
    my $out = shift();
    my( $in, $pre ) = ( @_, [] );

    push(@{$out}, [ @{$pre} ])
        unless(@$in);

    for (0 .. $#$in){
        permutations(
            $out,
            [ @{$in}[0 .. $_ - 1, $_ + 1 .. $#$in] ],
            [ @$pre, $in->[$_] ]
        );
    }

}



