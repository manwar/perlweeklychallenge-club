#!/usr/bin/env perl
#
=head1 Task 1: Count Prefixes

Submitted by: Mohammad Sajid Anwar

You are given an array of words and a string (contains only lowercase English
letters).  Write a script to return the number of words in the given array that
are a prefix of the given string.

=head2 Example 1

    Input: @array = ("a", "ap", "app", "apple", "banana"), $str = "apple"
    Output: 4

=head2 Example 2

    Input: @array = ("cat", "dog", "fish"), $str = "bird"
    Output: 0

=head2 Example 3

    Input: @array = ("hello", "he", "hell", "heaven", "he"), $str = "hello"
    Output: 4

=head2 Example 4

    Input: @array = ("", "code", "coding", "cod"), $str = "coding"
    Output: 3

=head2 Example 5

    Input: @array = ("p", "pr", "pro", "prog", "progr", "progra", "program"), $str = "program"
    Output: 7

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[["a", "ap", "app", "apple", "banana"],                      "apple"], 4, 'Example 1'],
    [[["cat", "dog", "fish"],                                      "bird"], 0, 'Example 2'],
    [[["hello", "he", "hell", "heaven", "he"],                    "hello"], 4, 'Example 3'],
    [[["", "code", "coding", "cod"],                             "coding"], 3, 'Example 4'],
    [[["p", "pr", "pro", "prog", "progr", "progra", "program"], "program"], 7, 'Example 5'],
];

sub count_prefixes
{
    my $arr = $_[0]->[0];
    my $str = $_[0]->[1];

    my $cnt = 0;
    for my $w (@$arr) {
        ++$cnt if substr($str, 0, length($w)) eq $w;
    }

    return $cnt;
}

for (@$cases) {
    is(count_prefixes($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
