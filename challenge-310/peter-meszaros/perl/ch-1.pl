#!/usr/bin/env perl
#
=head1 Task 1: Arrays Intersection

Submitted by: Mohammad Sajid Anwar

You are given a list of array of integers.

Write a script to return the common elements in all the arrays.

=head2 Example 1

    Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
    Output: (1, 4)

=head2 Example 2

    Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
    Output: (2)

=head2 Example 3

    Input: $list = ( [1, 2, 3], [4, 5], [6] )
    Output: ()

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw(uniqint);

my $cases = [
    [[[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]], [1, 4], 'Example 1'],
    [[[1, 0, 2, 3], [2, 4, 5]],                  [2],    'Example 2'],
    [[[1, 2, 3], [4, 5], [6]],                   [],     'Example 3'],
];

sub arrays_intersection
{
    my $lists = shift;

    my $numlists = @$lists;
    my %hash;
    for my $l (@$lists) {
        ++$hash{$_} for uniqint @$l;
    }
    return [sort {$a <=>$b} grep { $hash{$_} == $numlists} keys %hash];
}

for (@$cases) {
    is(arrays_intersection($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
