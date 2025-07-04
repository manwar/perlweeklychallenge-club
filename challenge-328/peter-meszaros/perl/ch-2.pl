#!/usr/bin/env perl
#
=head1 Task 2: Good String

Submitted by: Mohammad Sajid Anwar

You are given a string made up of lower and upper case English letters only.

Write a script to return the good string of the given string. A string is
called good string if it doesn't have two adjacent same characters, one in
upper case and other is lower case.

UPDATE [2025-07-01]: Just to be explicit, you can only remove pair if they are
same characters, one in lower case and other in upper case, order is not
important.

=head2 Example 1

    Input: $str = "WeEeekly"
    Output: "Weekly"

    We can remove either, "eE" or "Ee" to make it good.

=head2 Example 2

    Input: $str = "abBAdD"
    Output: ""

    We remove "bB" first: "aAdD"
    Then we remove "aA": "dD"
    Finally remove "dD".

=head2 Example 3

    Input: $str = "abc"
    Output: "abc"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["WeEeekly", "Weekly", "Example 1"],
    ["abBAdD",   "",       "Example 2"],
    ["abc",      "abc",    "Example 3"],
];

sub good_string
{
    my $str = shift;
    my @stack;

    for my $char (split //, $str) {
        if (@stack && lc($char) eq lc($stack[-1]) && $char ne $stack[-1]) {
            pop @stack;
        } else {
            push @stack, $char;
        }
    }

    return join('', @stack);
}

for (@$cases) {
    is(good_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
