#!/usr/bin/env perl
#
=head1 Task 2: Decode XOR

Submitted by: Mohammad Sajid Anwar

You are given an encoded array and an initial integer.

Write a script to find the original array that produced the given encoded
array. It was encoded such that encoded[i] = orig[i] XOR orig[i + 1].

=head2 Example 1

    Input: @encoded = (1, 2, 3), $initial = 1
    Output: (1, 0, 2, 1)

    Encoded array created like below, if the original array was (1, 0, 2, 1)
    $encoded[0] = (1 xor 0) = 1
    $encoded[1] = (0 xor 2) = 2
    $encoded[2] = (2 xor 1) = 3

=head2 Example 2

    Input: @encoded = (6, 2, 7, 3), $initial = 4
    Output: (4, 2, 0, 7, 4)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[1, 2, 3],    1], [1, 0, 2, 1],    'Example 1'],
    [[[6, 2, 7, 3], 4], [4, 2, 0, 7, 4], 'Example 2'],
];

sub decode_xor
{
    my $encoded = $_[0]->[0];
    my $initial = $_[0]->[1];
    
    my @orig = ($initial);
    push @orig, $encoded->[$_] ^ $orig[-1] for 0 .. $#$encoded;
    return \@orig;
}

for (@$cases) {
    is(decode_xor($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
