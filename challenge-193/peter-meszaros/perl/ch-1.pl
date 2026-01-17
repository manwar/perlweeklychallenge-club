#!/usr/bin/env perl
#
=head1 Task 1: Binary String

Submitted by: Mohammad S Anwar

You are given an integer, $n > 0.  Write a script to find all possible binary
numbers of size $n.

=head2 Example 1

    Input: $n = 2
    Output: 00, 11, 01, 10

=head2 Example 2

    Input: $n = 3
    Output: 000, 001, 010, 100, 111, 110, 101, 011

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [2, [qw/ 00  01  10  11/],                 "Example 1"],
    [3, [qw/000 001 010 011 100 101 110 111/], "Example 2"],
    [1, [qw/  0   1/],                         "Example 3"],
];

sub binary_string
{
    my $n = shift;
    my @result;
    my $total = 2**$n;

    push @result, sprintf("%0${n}b", $_) for 0 .. $total - 1;

    return \@result;
}

for (@$cases) {
    is(binary_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
