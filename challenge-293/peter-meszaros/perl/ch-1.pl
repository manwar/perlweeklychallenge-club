#!/usr/bin/env perl
#
=head1 Task 1: Similar Dominos

Submitted by: Mohammad Sajid Anwar

You are given a list of dominos, @dominos.

Write a script to return the number of dominoes that are similar to any other
domino.

    $dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a = c and
    b = d) or (a = d and b = c).

=head2 Example 1

    Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
    Output: 2

    Similar Dominos: $dominos[0], $dominos[1]

=head2 Example 2

    Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
    Output: 3

    Similar Dominos: $dominos[0], $dominos[1], $dominos[3]

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/uniqint/;

my $cases = [
    [[[1, 3], [3, 1], [2, 4], [6, 8]],         2, 'Example 1'],
    [[[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]], 3, 'Example 2'],
];

sub similar_dominos
{
    my $d = shift;

    my @d;
    for my $i1 (0 .. $#$d) {
        for my $i2 ($i1+1 .. $#$d) {
            push(@d, $i1, $i2) if $d->[$i1]->[0] == $d->[$i2]->[1] &&
                                  $d->[$i1]->[1] == $d->[$i2]->[0]
                                  ||
                                  $d->[$i1]->[0] == $d->[$i2]->[0] &&
                                  $d->[$i1]->[1] == $d->[$i2]->[1];
        }
    }
    return scalar uniqint @d;
}

for (@$cases) {
    is(similar_dominos($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
