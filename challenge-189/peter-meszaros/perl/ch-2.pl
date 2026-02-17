#!/usr/bin/env perl
#
=head1 Task 2: Array Degree

Submitted by: Mohammad S Anwar

You are given an array of 2 or more non-negative integers.  Write a script to
find out the smallest slice, i.e. contiguous subarray of the original array,
having the degree of the given array.  The degree of an array is the maximum
frequency of an element in the array.

=head2 Example 1

    Input: @array = (1, 3, 3, 2)
    Output: (3, 3)

    The degree of the given array is 2.
    The possible subarrays having the degree 2 are as below:
    (3, 3)
    (1, 3, 3)
    (3, 3, 2)
    (1, 3, 3, 2)

    And the smallest of all is (3, 3).

=head2 Example 2

    Input: @array = (1, 2, 1, 3)
    Output: (1, 2, 1)

=head2 Example 3

    Input: @array = (1, 3, 2, 1, 2)
    Output: (2, 1, 2)

=head2 Example 4

    Input: @array = (1, 1, 2, 3, 2)
    Output: (1, 1)

=head2 Example 5

    Input: @array = (2, 1, 2, 1, 1)
    Output: (1, 2, 1, 1)

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[1, 3, 3, 2],    [3, 3],       'Example 1'],
    [[1, 2, 1, 3],    [1, 2, 1],    'Example 2'],
    [[1, 3, 2, 1, 2], [2, 1, 2],    'Example 3'],
    [[1, 1, 2, 3, 2], [1, 1],       'Example 4'],
    [[2, 1, 2, 1, 1], [1, 2, 1, 1], 'Example 5'],
];

sub array_degree
{
    my $arr = shift;
    my %freq;
    my %first_index;
    my %last_index;

    for my $i (0 .. $#$arr) {
        my $val = $arr->[$i];
        $freq{$val}++;
        $first_index{$val} //= $i;
        $last_index{$val} = $i;
    }

    my $degree = 0;
    $degree = $_ > $degree ? $_ : $degree for values %freq;

    my $min_length = @$arr + 1;
    my @result;

    for my $val (keys %freq) {
        if ($freq{$val} == $degree) {
            my $length = $last_index{$val} - $first_index{$val} + 1;
            if ($length < $min_length) {
                $min_length = $length;
                @result = @{$arr}[$first_index{$val} .. $last_index{$val}];
            }
        }
    }

    return \@result;
}

for (@$cases) {
    is(array_degree($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
