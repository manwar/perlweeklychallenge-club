#!/usr/bin/env perl
#
=head1 Task 1: Equal Strings

Submitted by: Mohammad Sajid Anwar

You are given three strings.

You are allowed to remove the rightmost character of a string to make all
equals.

Write a script to return the number of operations to make it equal otherwise
-1.

=head2 Example 1

    Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
    Output: 2

    Operation 1: Delete "c" from the string "abc"
    Operation 2: Delete "b" from the string "abb"

=head2 Example 2

    Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
    Output: -1

=head2 Example 3

    Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
    Output: 3

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/max/;

my $cases = [
    [["abc", "abb", "ab"],   2, "Example 1"],
    [["ayz", "cyz", "xyz"], -1, "Example 2"],
    [["yza", "yzb", "yzc"],  3, "Example 3"],
];

sub equal_strings
{
    my $strings = shift;

    my @lengths = map { length $_ } @$strings;
    my $max = max @lengths;
    my $ops = 0;
    for my $i (0 .. $#$strings) {
        if ($lengths[$i] == $max) {
            ++$ops
        } elsif ($lengths[$i] < ($max - 1)) {
            $ops = -1;
            last;
        }
    }
    if ($ops != -1 &&
        !(substr($strings->[0], 0, $max-1) eq substr($strings->[1], 0, $max-1) &&
          substr($strings->[1], 0, $max-1) eq substr($strings->[2], 0, $max-1))) {
        $ops = -1;
    }

    return $ops;
}

for (@$cases) {
    is(equal_strings($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
