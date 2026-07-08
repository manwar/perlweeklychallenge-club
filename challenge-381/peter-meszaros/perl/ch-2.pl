#!/usr/bin/env perl
#
=head1 Task 2: Smaller Greater Element

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.  Write a script to find the number of
elements that have both a strictly smaller and greater element in the given
array.

=head2 Example 1

    Input: @int = (2,4)
    Output: 0

    Not enough elements in the array.

=head2 Example 2

    Input: @int = (1, 1, 1, 1)
    Output: 0

=head2 Example 3

    Input: @int = (1, 1, 4, 8, 12, 12)
    Output: 2

    The elements are 4 and 8.

=head2 Example 4

    Input: @int = (3, 6, 6, 9)
    Output: 2

    Both instances of 6.

=head2 Example 5

    Input: @int = (0, -5, 10, -2, 4)
    Output: 3

    The elements are 0, -2, and 4.

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use List::Util qw/min max/;

my @cases = (
    {int => [2,4],                out => 0, name => 'Example 1'},
    {int => [1, 1, 1, 1],         out => 0, name => 'Example 2'},
    {int => [1, 1, 4, 8, 12, 12], out => 2, name => 'Example 3'},
    {int => [3, 6, 6, 9],         out => 2, name => 'Example 4'},
    {int => [0, -5, 10, -2, 4],   out => 3, name => 'Example 5'},
);

sub smaller_greater_element
{
    my $int = shift;

    my $min = min(@$int);
    my $max = max(@$int);

    my $count = 0;
    for my $i (@$int) {
        if ($i > $min && $i < $max) {
            $count++;
        }
    }
    return $count;
}

for my $case (@cases) {
    my $got = smaller_greater_element($case->{int});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
