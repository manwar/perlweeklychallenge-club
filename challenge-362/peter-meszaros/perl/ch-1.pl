#!/usr/bin/env perl
#
=head1 Task 1: Echo Chamber

Submitted by: Mohammad Sajid Anwar

You are given a string containing lowercase letters.  Write a script to
transform the string based on the index position of each character (starting
from 0). For each character at position i, repeat it i + 1 times.

=head2 Example 1

    Input: "abca"
    Output: "abbcccaaaa"

    Index 0: "a" -> repeated 1 time  -> "a"
    Index 1: "b" -> repeated 2 times -> "bb"
    Index 2: "c" -> repeated 3 times -> "ccc"
    Index 3: "a" -> repeated 4 times -> "aaaa"

=head2 Example 2

    Input: "xyz"
    Output: "xyyzzz"

    Index 0: "x" -> "x"
    Index 1: "y" -> "yy"
    Index 2: "z" -> "zzz"

=head2 Example 3

    Input: "code"
    Output: "coodddeeee"

    Index 0: "c" -> "c"
    Index 1: "o" -> "oo"
    Index 2: "d" -> "ddd"
    Index 3: "e" -> "eeee"

=head2 Example 4

    Input: "hello"
    Output: "heelllllllooooo"

    Index 0: "h" -> "h"
    Index 1: "e" -> "ee"
    Index 2: "l" -> "lll"
    Index 3: "l" -> "llll"
    Index 4: "o" -> "ooooo"

=head2 Example 5

    Input: "a"
    Output: "a"

    Index 0: "a" -> "a"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [ "abca",      "abbcccaaaa", "Example 1" ],
    [  "xyz",          "xyyzzz", "Example 2" ],
    [ "code",      "coodddeeee", "Example 3" ],
    ["hello", "heelllllllooooo", "Example 4" ],
    [    "a",               "a", "Example 5" ],
];

sub echo_chamber
{
    my $str = shift;

    my $cnt = 0;
    return join '', map { $_ x ++$cnt } split //, $str;
}

for (@$cases) {
    is(echo_chamber($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
