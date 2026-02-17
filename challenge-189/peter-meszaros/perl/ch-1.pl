#!/usr/bin/env perl
#
=head1 Task 1: Greater Character

Submitted by: Mohammad S Anwar

You are given an array of characters (a..z) and a target character.  Write a
script to find out the smallest character in the given array lexicographically
greater than the target character.

=head2 Example 1

    Input: @array = qw/e m u g/, $target = 'b'
    Output: e

=head2 Example 2

    Input: @array = qw/d c e f/, $target = 'a'
    Output: c

=head2 Example 3

    Input: @array = qw/j a r/, $target = 'o'
    Output: r

=head2 Example 4

    Input: @array = qw/d c a f/, $target = 'a'
    Output: c

=head2 Example 5

    Input: @array = qw/t g a l/, $target = 'v'
    Output: v

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[[qw/e m u g/], 'b'], 'e', 'Example 1'],
    [[[qw/d c e f/], 'a'], 'c', 'Example 2'],
    [[[qw/j a r/],   'o'], 'r', 'Example 3'],
    [[[qw/d c a f/], 'a'], 'c', 'Example 4'],
    [[[qw/t g a l/], 'v'], 'v', 'Example 5'],
];

sub greater_character
{
    my $arr    = $_[0]->[0];
    my $target = $_[0]->[1];

    for my $ch (sort @$arr) {
        return $ch if $ch gt $target;
    }
    return $target;
}

for (@$cases) {
    is(greater_character($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
