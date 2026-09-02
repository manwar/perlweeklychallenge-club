#!/usr/bin/env perl
#
=head1 Task 2: ZigZag Subarray

Submitted by: Roger Bell_West

You are given an array of integers. Write a script to find the length of the
longest contiguous subarray where the numbers alternate between strictly
increasing and strictly decreasing (a ZigZag pattern). A sequence of numbers
$A = [a0, a1, ..., ak]$ with length $k >= 1 is considered a ZigZag sequence if
every adjacent pair alternates direction:
    a_0 < a_1 > a_2 < a_3 > ...
    OR
    a_0 > a_1 < a_2 > a_3 < ...

NOTE: A single element (length 1) or any two distinct elements (length 2) are
automatically valid ZigZag sequences. Equal adjacent numbers (e.g., 5, 5) break
the pattern.

=head2 Example 1

    Input: @nums = (9, 4, 2, 10, 7, 8, 8, 1, 9)
    Output: 5

    ZigZag subarray: (4, 2, 10, 7, 8)

=head2 Example 2

    Input: @nums = (1, 7, 4, 9, 2, 5)
    Output: 6

    ZigZag subarray: (1, 7, 4, 9, 2, 5)

=head2 Example 3

    Input: @nums = (1, 2, 3, 4, 5)
    Output: 2

    ZigZag subarray: (1, 2)

=head2 Example 4

    Input: @nums = (4, 4, 4)
    Output: 1

=head2 Example 5

    Input: @nums = (10, 20, 15, 12, 18)
    Output: 3

    ZigZag subarray: (10, 20, 15)

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use List::Util qw/max/;

my @cases = (
    {nums => [9, 4, 2, 10, 7, 8, 8, 1, 9], out => 5, name => 'Example 1'},
    {nums => [1, 7, 4, 9, 2, 5],           out => 6, name => 'Example 2'},
    {nums => [1, 2, 3, 4, 5],              out => 2, name => 'Example 3'},
    {nums => [4, 4, 4],                    out => 1, name => 'Example 4'},
    {nums => [10, 20, 15, 12, 18],         out => 3, name => 'Example 5'},
);

sub zigzag_subarray
{
    my $nums = shift;

    my $max_len = 1;
    my $current_len = 1;
    
    # -1: expect down, 1: expect up, 0: there is no trend yet (first element)
    my $expected_sign = 0;

    for my $i (1 .. @$nums-1) {
        if ($nums->[$i] > $nums->[$i-1]) {
            if ($expected_sign == 1 or $expected_sign == 0) {
                $current_len++;
                $expected_sign = -1;
            } else {
                $current_len = 2;
                $expected_sign = -1;
            }
        } elsif ($nums->[$i] < $nums->[$i-1]) {
            if ($expected_sign == -1 or $expected_sign == 0) {
                $current_len++;
                $expected_sign = 1;
            } else {
                $current_len = 2;
                $expected_sign = 1;   # A következőnek növekedésnek kell lennie
            }
        } else {
            $current_len = 1;
            $expected_sign = 0;
        }
        $max_len = max($max_len, $current_len);
    }

    return $max_len;
}

for my $case (@cases) {
    my $got = zigzag_subarray($case->{nums});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
