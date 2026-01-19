#!/usr/bin/env perl
#
=head1 Task 1: Binary Flip

Submitted by: Mohammad S Anwar

You are given a positive integer, $n.  Write a script to find the binary flip.

=head2 Example 1

    Input: $n = 5
    Output: 2

    First find the binary equivalent of the given integer, 101.
    Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.
    So Binary 010 => Decimal 2.

=head2 Example 2

    Input: $n = 4
    Output: 3

    Decimal 4 = Binary 100
    Flip 0 -> 1 and 1 -> 0, we get 011.
    Binary 011 = Decimal 3

=head2 Example 3

    Input: $n = 6
    Output: 1

    Decimal 6 = Binary 110
    Flip 0 -> 1 and 1 -> 0, we get 001.
    Binary 001 = Decimal 1

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [5, 2, "Example 1"],
    [4, 3, "Example 2"],
    [6, 1, "Example 3"],
];

sub binary_flip
{
    my $n = shift;
    my $bin = sprintf("%b", $n);
    my $flipped_bin = $bin =~ tr/01/10/r;
    return oct("0b$flipped_bin");
}

for (@$cases) {
    is(binary_flip($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
