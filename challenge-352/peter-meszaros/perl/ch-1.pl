#!/usr/bin/env perl
#
=head1 Task 1: Match String

Submitted by: Mohammad Sajid Anwar

You are given an array of strings.

Write a script to return all strings that are a substring of another word in
the given array in the order they occur.

=head2 Example 1

    Input: @words = ("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat")
    Output: ("cat", "dog", "dogcat", "rat")

=head2 Example 2

    Input: @words = ("hello", "hell", "world", "wor", "ellow", "elloworld")
    Output: ("hell", "world", "wor", "ellow")

=head2 Example 3

    Input: @words = ("a", "aa", "aaa", "aaaa")
    Output: ("a", "aa", "aaa")

=head2 Example 4

    Input: @words = ("flower", "flow", "flight", "fl", "fli", "ig", "ght")
    Output: ("flow", "fl", "fli", "ig", "ght")

=head2 Example 5

    Input: @words = ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")
    Output: ("car", "pet", "enter", "pen", "pent")

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use List::Util qw/uniq/;

my $cases = [
    [["cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"],
        ["cat", "dog", "dogcat", "rat"],        "Example 1"],
    [["hello", "hell", "world", "wor", "ellow", "elloworld"],
        ["hell", "world", "wor", "ellow"],      "Example 2"],
    [["a", "aa", "aaa", "aaaa"],
        ["a", "aa", "aaa"],                     "Example 3"],
    [["flower", "flow", "flight", "fl", "fli", "ig", "ght"],
        ["flow", "fl", "fli", "ig", "ght"],     "Example 4"],
    [["car", "carpet", "carpenter", "pet", "enter", "pen", "pent"],
        ["car", "pet", "enter", "pen", "pent"], "Example 5"],
];

sub match_string
{
    my $words = shift;
    my @result;
    for my $i (0 .. $#$words) {
        for my $j (0 .. $#$words) {
            next if $i == $j;
            if (index($words->[$j], $words->[$i]) != -1) {
                push @result, $words->[$i];
                last;
            }
        }
    }
    return [uniq @result];
}

for (@$cases) {
    is(match_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
