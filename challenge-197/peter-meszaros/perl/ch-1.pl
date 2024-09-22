#!/usr/bin/env perl
#
=head1 Task 1: Move Zero

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to move all zero, if exists, to the end while maintaining the
relative order of non-zero elements.

=head2 Example 1

    Input:  @list = (1, 0, 3, 0, 0, 5)
    Output: (1, 3, 5, 0, 0, 0)

=head2 Example 2

    Input: @list = (1, 6, 4)
    Output: (1, 6, 4)

=head2 Example 3

    Input: @list = (0, 1, 0, 2, 0)
    Output: (1, 2, 0, 0, 0)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 0, 3, 0, 0, 5], [1, 3, 5, 0, 0, 0], 'Example 1'],
    [[1, 6, 4],          [1, 6, 4],          'Example 2'],
    [[0, 1, 0, 2, 0],    [1, 2, 0, 0, 0],    'Example 3'],
];

sub move_zero
{
    my $l = shift;

    my @res = grep {$_} @$l;
    push @res, (0) x (@$l - @res);

    return \@res;
}

for (@$cases) {
    is(move_zero($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
