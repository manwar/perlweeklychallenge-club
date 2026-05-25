#!/usr/bin/env perl
#
=head1 Task 1: Single Common Word

Submitted by: Mohammad Sajid Anwar

You are given two array of strings.  Write a script to return the number of
strings that appear exactly once in each of the two given arrays. String
comparison is case sensitive.

=head2 Example 1

    Input: @array1 = ("apple", "banana", "cherry")
           @array2 = ("banana", "cherry", "date")
    Output: 2

=head2 Example 2

    Input: @array1 = ("a", "ab", "abc")
           @array2 = ("a", "a", "ab", "abc")
    Output: 2

    "a" appears once in @array1 but appears twice in @array2, therefore, not counted.

=head2 Example 3

    Input: @array1 = ("orange", "lemon")
           @array2 = ("grape", "melon")
    Output: 0

=head2 Example 4

    Input: @array1 = ("test", "test", "demo")
           @array2 = ("test", "demo", "demo")
    Output: 0

=head2 Example 5

    Input: @array1 = ("Hello", "world")
           @array2 = ("hello", "world")
    Output: 1

    String comparison is case sensitive.

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[["apple", "banana", "cherry"], ["banana", "cherry", "date"]], 2, "Example 1"],
    [[["a", "ab", "abc"],            ["a", "a", "ab", "abc"]],      2, "Example 2"],
    [[["orange", "lemon"],           ["grape", "melon"]],           0, "Example 3"],
    [[["test", "test", "demo"],      ["test", "demo", "demo"]],     0, "Example 4"],
    [[["Hello", "world"],            ["hello", "world"]],           1, "Example 5"],
];

sub single_common_word
{
    my $array1 = $_[0]->[0];
    my $array2 = $_[0]->[1];

    my %count1;
    $count1{$_}++ for @$array1;

    my %count2;
    $count2{$_}++ for @$array2;

    my $result = 0;
    for my $word (keys %count1) {
        $result++ if $count1{$word} == 1 && exists $count2{$word} && $count2{$word} == 1;
    }

    return $result;
}

for (@$cases) {
    is(single_common_word($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
