#!/usr/bin/env perl
#
=head1 Task 2: Arrange Box

Submitted by: Mohammad Sajid Anwar

You are given an array of box dimensions.  Write a script to determine the
maximum number of these boxes that can fit inside each other in a single stack.
For a box to fit inside another, it must be smaller in both dimensions.

=head2 Example 1

    Input: @boxes = ([1, 3], [3, 5], [6, 8], [2, 4])
    Output: 4

    Sort by width ascending: ([1, 3], [2, 4], [3, 5], [6, 8])
    Extract heights: [3, 4, 5, 8]
    [1, 3] -> [2, 4] -> [3, 5] -> [6, 8]

=head2 Example 2

    Input: @boxes = ([4, 5], [4, 6], [6, 7], [2, 3], [4, 3])
    Output: 3

    Sort by width ascending: ([2, 3], [4, 6], [4, 5], [4, 3], [6, 7])
    Extract heights: (3, 6, 5, 3, 7)
    [2, 3] -> [4, 5] -> [6, 7]

=head2 Example 3

    Input: @boxes = ([5, 5], [5, 5], [5, 5])
    Output: 1

    Sort by width ascending: ([5, 5], [5, 5], [5, 5])
    Extract heights: (5, 5, 5)
    [5, 5]

=head2 Example 4

    Input: @boxes = ([2, 100], [3, 200], [4, 300], [5, 50], [5, 400])
    Output: 4

    Sort by width ascending: ([2, 100], [3, 200], [4, 300], [5, 400], [5, 50])
    Extract heights: (100, 200, 300, 400, 50)
    [2, 100] -> [3, 200] -> [4, 300] -> [5, 400]

=head2 Example 5

    Input: @boxes = ([10, 20], [15, 10], [20, 30], [12, 18], [16, 25])
    Output: 3

    Sort by width ascending: ([10, 20], [12, 18], [15, 10], [16, 25], [20, 30])
    Extract heights: (20, 18, 10, 25, 30)
    [15, 10] -> [16, 25] -> [20, 30]

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {boxes => [[1, 3], [3, 5], [6, 8], [2, 4]],                   out => 4, name => 'Example 1'},
    {boxes => [[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]],           out => 3, name => 'Example 2'},
    {boxes => [[5, 5], [5, 5], [5, 5]],                           out => 1, name => 'Example 3'},
    {boxes => [[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]],  out => 4, name => 'Example 4'},
    {boxes => [[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]], out => 3, name => 'Example 5'},
);

sub arrange_box
{
    my ($boxes) = @_;
    my @sorted = sort { $a->[0] <=> $b->[0]} @$boxes;
    my @result = shift @sorted;
    for my $box (@sorted) {
        push @result, $box if ($box->[0] > $result[-1]->[0] &&
                               $box->[1] > $result[-1]->[1]);
    }
    return scalar @result;
}

for my $case (@cases) {
    my $got = arrange_box($case->{boxes});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
