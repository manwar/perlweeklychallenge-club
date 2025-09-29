#!/usr/bin/env perl
#
=head1 Task 2: Reverse Prefix

Submitted by: Mohammad Sajid Anwar

You are given a string, $str and a character in the given string, $char.

Write a script to reverse the prefix upto the first occurrence of the given
$char in the given string $str and return the new string.

=head2 Example 1

    Input: $str = "programming", $char = "g"
    Output: "gorpramming"

    Reverse of prefix "prog" is "gorp".

=head2 Example 2

    Input: $str = "hello", $char = "h"
    Output: "hello"

=head2 Example 3

    Input: $str = "abcdefghij", $char = "h"
    Output: "hgfedcbaij"

=head2 Example 4

    Input: $str = "reverse", $char = "s"
    Output: "srevere"

=head2 Example 5

    Input: $str = "perl", $char = "r"
    Output: "repl"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["programming",  "g"], "gorpramming", "Example 1"],
    [["hello",        "h"], "hello",       "Example 2"],
    [["abcdefghij",   "h"], "hgfedcbaij",  "Example 3"],
    [["reverse",      "s"], "srevere",     "Example 4"],
    [["perl",         "r"], "repl",        "Example 5"],
];

sub reverse_prefix
{
    my $str  = $_[0]->[0];
    my $char = $_[0]->[1];

    my $pos = index $str, $char;
    return $str if $pos == -1;

    return reverse(substr($str, 0, $pos + 1)) . substr($str, $pos + 1);
}

for (@$cases) {
    is(reverse_prefix($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
