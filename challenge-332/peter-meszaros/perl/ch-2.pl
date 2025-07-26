#!/usr/bin/env perl
#
=head1 Task 2: Odd Letters

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to find out if each letter in the given string appeared odd
number of times.

=head2 Example 1

    Input: $str = "weekly"
    Output: false

    w: 1 time
    e: 2 times
    k: 1 time
    l: 1 time
    y: 1 time

    The letter 'e' appeared 2 times i.e. even.

=head2 Example 2

    Input: $str = "perl"
    Output: true

=head2 Example 3

    Input: $source = "challenge"
    Output: false

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["weekly",    0, "Example 1"],
    ["perl",      1, "Example 2"],
    ["challenge", 0, "Example 3"],
];

sub odd_letters
{
    my $str = shift;

    my %count;
    $count{$_}++ for split //, $str;
    for my $letter (keys %count) {
        return 0 unless $count{$letter} % 2;
    }
    return 1;
}

for (@$cases) {
    is(odd_letters($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
