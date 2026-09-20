#!/usr/bin/perl
use strict;
use warnings;

# A median is the middle value of a set of numbers after the numbers
# have been put in ascending order.

# With an odd number of values, the median is the single middle value.
# Example: 1, 3, 7, 9, 12: median = 7
# With an even number of values, there are two middle values, so the
# median is their average.
# Example: 1, 3, 7, 9: median = (3 + 7) / 2 = 5

sub array_median {

    # Get the two array references passed to the subroutine.
    # $a1 and $a2 refer to the original arrays.
    my ($a1, $a2) = @_;

    # Dereference both array references and combine their elements
    # into one list. Sort the numbers in ascending numerical order.
    # The <=> operator is Perl's numerical comparison operator.
    my @arr = sort({ $a <=> $b } (@$a1, @$a2));

    # In scalar context, an array gives its number of elements,
    # so 'scalar' in 'my $arr_len = scalar @arr;' can be left out here.
    my $arr_len = @arr;

    # If $arr_len is odd, use the first expression; otherwise, use
    # the second expression.
    return ($arr_len % 2)
        ? $arr[($arr_len - 1) / 2]
        : ($arr[($arr_len - 1) / 2] + $arr[$arr_len / 2]) / 2;
}

# Tests

my @arr1;
my @arr2;

# Example 1
@arr1 = (2);
@arr2 = (4);
printf "%.1f\n", array_median (\@arr1, \@arr2); # Output: 3.0

# Example 2
@arr1 = (1,2,3);
@arr2 = (7,8,9,10);
printf "%.1f\n", array_median (\@arr1, \@arr2); # Output: 7.0

# Example 3
@arr1 = ();
@arr2 = (10,20,30,40);
printf "%.1f\n", array_median (\@arr1, \@arr2); # Output: 25.0

# Example 4
@arr1 = (100);
@arr2 = (1,2,3,4,5,6,7);
printf "%.1f\n", array_median (\@arr1, \@arr2); # Output: 4.5

# Example 5
@arr1 = (1,2,2);
@arr2 = (2,2,3);
printf "%.1f\n", array_median (\@arr1, \@arr2); # Output: 2.0
