#!/usr/bin/env perl
#
=head1 Task 1: Missing Numbers

Submitted by: Mohammad S Anwar

You are given an array of unique numbers.

Write a script to find out all missing numbers in the range 0..$n where $n is
the array size.

=head2 Example 1

    Input: @array = (0,1,3)
    Output: 2

    The array size i.e. total element count is 3, so the range is 0..3.
    The missing number is 2 in the given array.

=head2 Example 2

    Input: @array = (0,1)
    Output: 2

    The array size is 2, therefore the range is 0..2.
    The missing number is 2.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[0, 1, 3], [2],    'Example 1'],
    [[0, 1],    [2],    'Example 2'],
    [[0, 2, 4], [1, 3], 'Example 3'],
];

sub missing_numbers
{
    my $l = shift;

    my $n = @$l;
    my %h = map {$_ => 1} 0 .. $n;

    delete @h{@$l};

    return [sort {$a <=> $b} keys %h];
}

for (@$cases) {
    is(missing_numbers($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
