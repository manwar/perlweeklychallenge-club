#!/usr/bin/env perl
#
=head1 Task 1: Array Median

Submitted by: Mohammad Sajid Anwar You are given two sorted arrays.  Write a
script to merge the two given sorted arrays and return the median of the merged
array.

=head2 Example 1

    Input: @arr1 = (2), @arr2 = (4)
    Output: 3.0

    Merged array: (2,4)
    Median: (2+4)/2 => 3

=head2 Example 2

    Input: @arr1 = (1,2,3), @arr2 = (7,8,9,10)
    Output: 7.0

    Merged array: (1,2,3,7,8,9,10)
    Length of merged array is 7, the 4th element is 7.

=head2 Example 3

    Input: @arr1 = (), @arr2 = (10,20,30,40)
    Output: 25.0

    Merged array: (10,20,30,40)
    Median: (20+30)/2 => 25

=head2 Example 4

    Input: @arr1 = (100), @arr2 = (1,2,3,4,5,6,7)
    Output: 4.5

    Merged array: (1,2,3,4,5,6,7,100)
    Median: (4+5)/2 => 4.5

=head2 Example 5

    Input: @arr1 = (1,2,2), @arr2 = (2,2,3)
    Output: 2.0

    Merged array: (1,2,2,2,2,3)
    Median: (2+2)/2 => 2

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {arr1 => [2],     arr2 => [4],             out => 3.0,  name => 'Example 1'},
    {arr1 => [1,2,3], arr2 => [7,8,9,10],      out => 7.0,  name => 'Example 2'},
    {arr1 => [],      arr2 => [10,20,30,40],   out => 25.0, name => 'Example 3'},
    {arr1 => [100],   arr2 => [1,2,3,4,5,6,7], out => 4.5,  name => 'Example 4'},
    {arr1 => [1,2,2], arr2 => [2,2,3],         out => 2.0,  name => 'Example 5'},
);

sub array_median
{
    my ($arr1, $arr2) = @_;

    my @arr = sort {$a <=> $b} (@$arr1, @$arr2);
    my $len = @arr;
    return ($len % 2 == 1) ? $arr[int($len/2)] : ($arr[$len/2 - 1] + $arr[$len/2]) / 2;
}

for my $case (@cases) {
    my $got = array_median($case->{arr1}, $case->{arr2});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
