#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 397 Task 1: Absent Smallest Positive
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum );

sub absent_smallest_positive( @arr ) {
    # All example arrays are sorted, but the task description doesn't make
    # this mandatory, so we sort the array first.
    @arr = sort { $a <=> $b } @arr;

    # First guess for the target number is first *positive* integer
    # that is strictly greater than the average:
    my $avg = sum( @arr ) / @arr;
    my $target = $avg <= 0 ? 1 : int( $avg ) + 1;

    # Now, we loop over the (sorted) array elements until we find an entry
    # that is larger than or equal to the target number.
    # If the entry is larger (but not equal), we know that our target number
    # is not present in the array, and we can directly return it as the result.
    # If the entry is *equal* to our target number, we increment the target
    # number and continue trying with the new value.
    # Once we reach the end of the array, we can safely return the current
    # target value, because we know it is larger than the last number
    # in the array.
    for ( @arr ) {
        return $target if $_ > $target;
        ++$target if $_ == $target;
    }
    return $target;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [1, 2, 4, 5, 6], 7 ],
    [ "Example 2", [-5, -2, -1, 3], 1 ],
    [ "Example 3", [1, 2, 3], 4 ],
    [ "Example 4", [2, 3, 7, 8], 6 ],
    [ "Example 5", [1, 1, 1, 10], 4 ],
);

is absent_smallest_positive( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;

done_testing;
