#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_sets = (
    [ 1,        1000,     1 ],
    [ 1500,     2500,     1 ],
    [ 1000000,  1500000,  5 ],
    [ 13427000, 14100000, 2 ],
    [ 1030,     1130,     1 ]
);

print("\n");
foreach my $integer_set (@integer_sets){
    printf(
        "Input: \$from = %d, \$to = %d, \$count = %d\nOutput: %d\n\n",
        $integer_set->[0],
        $integer_set->[1],
        $integer_set->[2],
        count_qualifying_shuffle_pair_sets(@{$integer_set})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an inclusive range of integers to examine and a quantity of Shuffle
# Pairs to look for, determine how many numbers within this range can form a
# number of Shuffle Pairs equal to or greater than the specified quantity; a
# Shuffle Pair is defined as a pair of numbers with the same digits, albeit in
# different orders, such that the larger can be calculated by multiplying the
# smaller by an integer value (e.g. 1359 * 7 = 9513).  It is possible for an
# integer to belong to multiple Shuffle Pairs (e.g. 123876 * 3 = 371628,
# 123876 * 7 = 867132) hence the specified Pair count.
# Takes three arguments:
# * The first integer to examine (e.g. 13427000)
# * The last integer to examine (e.g. 14100000)
# * The desired count of Shuffle Pairs per integer within the specified range
#   (e.g. 2)
# Returns:
# * The number of integers within the specified range that are part of at least
#   the specified number of Shuffle Pairs (e.g. 11)
################################################################################
sub count_qualifying_shuffle_pair_sets{
    my ($from, $to, $target_count) = @ARG;

    my $sorted_digits;
    my $digit_count;
    my $multiplier;
    my $product;
    my $pair_count;
    my $pair_sets_count = 0;

    # Loop over the specified range
    for my $i ($from .. $to){
        # Store the digits in this number in sorted order
        # for comparison later
        $sorted_digits = join("", sort(split(//, $i)));
        $digit_count = length($i);
        $pair_count = 0;

        # Multiply $i by numbers from 2 to 9 since 1 and 10
        # are guaranteed to produce results we don't want
        for $multiplier (2 .. 9){
            $product = $i * $multiplier;

            # Break off the search if we've generated additional
            # digits
            last
                unless(length($product) == $digit_count);

            # Add to the pair count for this number if the
            # product has the same digits as the original
            # number
            $pair_count++
                if(join("", sort(split(//, $product))) eq $sorted_digits);
        }

        # Add to the count of qualifying pair counts if
        # this pair count, er, qualifies
        $pair_sets_count++
            if($pair_count >= $target_count);
    }

    return($pair_sets_count);

}



