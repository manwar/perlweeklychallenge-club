#!/usr/bin/env perl
#
=head1 Task 2: Trionic Array

Submitted by: Mohammad Sajid Anwar

You are given an array of integer.  Write a script to return true if the given
array is Trionic otherwise return false.  An array is trionic if there exist
indices 0 < p < q < n - 1 such that arr[0...p] is strictly increasing,
arr[p...q] is strictly decreasing, and arr[q...n - 1] is strictly
increasing.

=head2 Example 1

    Input: @arr = (1, 3, 5, 4, 2, 6, 8)
    Output: true

    Choose p = 2 and q = 4
    $arr[0..2] = (1, 3, 5) (strictly increasing)
    $arr[2..4] = (5, 4, 2) (strictly decreasing)
    $arr[4..6] = (2, 6, 8) (strictly increasing)

    Valid indices: 0 < p (2) < q (4) < n-1 (6).

=head2 Example 2

    Input: @arr = (1, 4, 4, 2, 1, 3, 5)
    Output: false

    The first segment (1, 4, 4) contains duplicate adjacent values, so it is
    not strictly increasing.
    No valid p and q exist to satisfy all three strictly monotonic conditions.

=head2 Example 3

    Input: @arr = (2, 10, 3, 1, 9)
    Output: true

    Choose p = 1 and q = 3.
    $arr[0..1] = (2, 10)    (strictly increasing)
    $arr[1..3] = (10, 3, 1) (strictly decreasing)
    $arr[3..4] = (1, 9)     (strictly increasing)

=head2 Example 4

    Input: @arr = (1, 2, 3, 4, 3, 2, 1)
    Output: false

    This is a standard mountain array (strictly increasing, then strictly decreasing).
    There is no second valley (q) that transitions back into a strictly
    increasing third segment before reaching the end of the array.

=head2 Example 5

    Input: @arr = (1, 3, 6, 4, 2, 7, 8, 4)
    Output: false

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {arr => [1, 3, 5, 4, 2, 6, 8],    out => true,  name => 'Example 1'},
    {arr => [1, 4, 4, 2, 1, 3, 5],    out => false, name => 'Example 2'},
    {arr => [2, 10, 3, 1, 9],         out => true,  name => 'Example 3'},
    {arr => [1, 2, 3, 4, 3, 2, 1],    out => false, name => 'Example 4'},
    {arr => [1, 3, 6, 4, 2, 7, 8, 4], out => false, name => 'Example 5'},
);

sub trionic_array
{
    my $arr = shift;

    my $n = @$arr;

    LOOP1: for (my $p = 1; $p < $n - 1; $p++) {
        for (my $i = 1; $i <= $p; $i++) {
            next LOOP1 if $arr->[$i] <= $arr->[$i - 1];
        }

        LOOP2: for (my $q = $p + 1; $q < $n - 1; $q++) {
            for (my $i = $p + 1; $i <= $q; $i++) {
                next LOOP2 if $arr->[$i] >= $arr->[$i - 1];
            }
            for (my $i = $q + 1; $i < $n; $i++) {
                next LOOP2 if $arr->[$i] <= $arr->[$i - 1];
            }
            return true;
        }
    }
    return false;
}

for my $case (@cases) {
    my $got = trionic_array($case->{arr});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
