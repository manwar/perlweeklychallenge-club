#!/usr/bin/env perl
#
=head1 Task 2: Buddy Strings

Submitted by: Mohammad Sajid Anwar

You are given two strings, source and target.

Write a script to find out if the given strings are Buddy Strings.

If swapping of a letter in one string make them same as the other then they are
`Buddy Strings`.

=head2 Example 1

    Input: $source = "fuck"
           $target = "fcuk"
    Output: true

    The swapping of 'u' with 'c' makes it buddy strings.

=head2 Example 2

    Input: $source = "love"
           $target = "love"
    Output: false

=head2 Example 3

    Input: $source = "fodo"
           $target = "food"
    Output: true

=head2 Example 4

    Input: $source = "feed"
           $target = "feed"
    Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["fuck", "fcuk"], 1, "Example 1"],
    [["love", "love"], 0, "Example 2"],
    [["fodo", "food"], 1, "Example 3"],
    [["feed", "feed"], 1, "Example 4"],
];

sub buddy_strings
{
    my $source = $_[0]->[0];
    my $target = $_[0]->[1];

    my $buddy = 0;
    if (length($source) == length($target)) {
        for my $i (0 .. length($source) - 1) {
            my $j = index($target, substr($source, $i, 1), $i + 1);
            if ($j != -1 and substr($source, $j, 1) eq substr($target, $i, 1)) {
                if ($buddy) {
                    $buddy = 0;
                    last;
                }
                $buddy = 1;
            }
        }
    }

    return $buddy;
}

for (@$cases) {
    is(buddy_strings($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
