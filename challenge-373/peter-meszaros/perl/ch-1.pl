#!/usr/bin/env perl
#
=head1 Task 1: Equal List

Submitted by: Mohammad Sajid Anwar

You are given two arrays of strings.  Write a script to return true if the two
given array represent the same strings otherwise false.

=head2 Example 1

    Input: @arr1 = ("a", "bc")
           @arr2 = ("ab", "c")
    Output: true

    Array 1: "a" + "bc" = "abc"
    Array 2: "ab" + "c" = "abc"

=head2 Example 2

    Input: @arr1 = ("a", "b", "c")
           @arr2 = ("a", "bc")
    Output: true

    Array 1: "a" + "b" + "c" = "abc"
    Array 2: "a" + "bc" = "abc"

=head2 Example 3

    Input: @arr1 = ("a", "bc")
           @arr2 = ("a", "c", "b")
    Output: false

    Array 1: "a" + "bc" = "abc"
    Array 2: "a" + "c" + "b" = "acb"

=head2 Example 4

    Input: @arr1 = ("ab", "c", "")
           @arr2 = ("", "a", "bc")
    Output: true

    Array 1: "ab" + "c" + "" = "abc"
    Array 2: ""  + "a" + "bc" = "abc"

=head2 Example 5

    Input: @arr1 = ("p", "e", "r", "l")
           @arr2 = ("perl")
    Output: true

    Array 1: "p" + "e" + "r" + "l" = "perl"
    Array 2: "perl"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[["a", "bc"],          ["ab", "c"]],     true,  "Example 1"],
    [[["a", "b", "c"],      ["a", "bc"]],     true,  "Example 2"],
    [[["a", "bc"],          ["a", "c", "b"]], false, "Example 3"],
    [[["ab", "c", ""],      ["", "a", "bc"]], true,  "Example 4"],
    [[["p", "e", "r", "l"], ["perl"]],        true,  "Example 5"],
];

sub equal_list
{
    return join("", $_[0]->[0]->@*) eq join("", $_[0]->[1]->@*);
}

for (@$cases) {
    is(equal_list($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
