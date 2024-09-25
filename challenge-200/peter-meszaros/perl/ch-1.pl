#!/usr/bin/env perl
#
=head1 Task 1: Arithmetic Slices

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out all Arithmetic Slices for the given array of
integers.

    An integer array is called arithmetic if it has at least 3 elements and the
    differences between any three consecutive elements are the same.

=head2 Example 1

    Input: @array = (1,2,3,4)
    Output: (1,2,3), (2,3,4), (1,2,3,4)

=head2 Example 2

    Input: @array = (2)
    Output: () as no slice found.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 2, 3, 4], [[1, 2, 3], [1, 2, 3, 4], [2, 3, 4]], 'Example 1'],
    [[2],          [],                                   'Example 2'],
];

sub arithmetic_slices
{
    my $l = shift;

    return [] if @$l < 3;

    my @res;
    for my $i (0 .. $#$l-2) {
        if ($l->[$i+1] - $l->[$i] == $l->[$i+2] - $l->[$i+1]) {
            my $diff = $l->[$i+1] - $l->[$i];
            my @aseq = $l->@[$i, $i+1, $i+2];
            push @res, [@aseq];
            for my $j ($i+3 .. $#$l) {
                last if $l->[$j] - $l->[$j-1] != $diff;
                push @aseq, $l->[$j];
                push @res, [@aseq];
            }
        }
    }
    return \@res;
}

for (@$cases) {
    is(arithmetic_slices($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
