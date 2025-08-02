#!/usr/bin/env perl
#
=head1 Task 2: H-Index

Submitted by: Mohammad S Anwar

You are given an array of integers containing citations a researcher has
received for each paper.

Write a script to compute the researcher's H-Index. For more information please
checkout the wikipedia page.

    The H-Index is the largest number h such that h articles have at least h
    citations each. For example, if an author has five publications, with 9, 7,
    6, 2, and 1 citations (ordered from greatest to least), then the author's
    h-index is 3, because the author has three publications with 3 or more
    citations. However, the author does not have four publications with 4 or
    more citations.

=head2 Example 1

    Input: @citations = (10,8,5,4,3)
    Output: 4

    Because the 4th publication has 4 citations and the 5th has only 3.

=head2 Example 2

    Input: @citations = (25,8,5,3,3)
    Output: 3

    The H-Index is 3 because the fourth paper has only 3 citations.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[10, 8, 5, 4, 3], 4, 'Example 1'],
    [[25, 8, 5, 3, 3], 3, 'Example 2'],
];

sub h_index
{
    my $l = shift;

    my $h = 0;

    for my $i (0 .. $#$l) {
        if ($l->[$i] < $i) {
            $h = $l->[$i-1];
            last;
        }
    }
    return $h;
}

for (@$cases) {
    is(h_index($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
