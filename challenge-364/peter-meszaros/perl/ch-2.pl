#!/usr/bin/env perl
#
=head1 Task 2: Goal Parser

Submitted by: Mohammad Sajid Anwar

You are given a string, $str.  Write a script to interpret the given string
using Goal Parser.  The Goal Parser interprets "G" as the string "G", "()" as
the string "o", and "(al)" as the string "al". The interpreted strings are then
concatenated in the original order.

=head2 Example 1

    Input: $str = "G()(al)"
    Output: "Goal"

    G    -> "G"
    ()   -> "o"
    (al) -> "al"

=head2 Example 2

    Input: $str = "G()()()()(al)"
    Output: "Gooooal"

    G       -> "G"
    four () -> "oooo"
    (al)    -> "al"

=head2 Example 3

    Input: $str = "(al)G(al)()()"
    Output: "alGaloo"

    (al) -> "al"
    G    -> "G"
    (al) -> "al"
    ()   -> "o"
    ()   -> "o"

=head2 Example 4

    Input: $str = "()G()G"
    Output: "oGoG"

    () -> "o"
    G  -> "G"
    () -> "o"
    G  -> "G"

=head2 Example 5

    Input: $str = "(al)(al)G()()"
    Output: "alalGoo"

    (al) -> "al"
    (al) -> "al"
    G    -> "G"
    ()   -> "o"
    ()   -> "o"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [      "G()(al)",    "Goal", 'Example 1'],
    ["G()()()()(al)", "Gooooal", 'Example 2'],
    ["(al)G(al)()()", "alGaloo", 'Example 3'],
    [       "()G()G",    "oGoG", 'Example 4'],
    ["(al)(al)G()()", "alalGoo", 'Example 5'],
];

sub goal_parser
{
    my $str = shift;
    $str =~ s/\(\)/o/g;
    $str =~ s/\(al\)/al/g;
    return $str;
}

for (@$cases) {
    is(goal_parser($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
