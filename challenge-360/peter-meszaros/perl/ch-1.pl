#!/usr/bin/env perl
#
=head1 Task 1: Text Justifier

Submitted by: Mohammad Sajid Anwar

You are given a string and a width.  Write a script to return the string that
centers the text within that width using asterisks * as padding.

=head2 Example 1

    Input: $str = "Hi", $width = 5
    Output: "*Hi**"

    Text length = 2, Width = 5
    Need 3 padding characters total
    Left padding: 1 star, Right padding: 2 stars

=head2 Example 2

    Input: $str = "Code", $width = 10
    Output: "***Code***"

    Text length = 4, Width = 10
    Need 6 padding characters total
    Left padding: 3 stars, Right padding: 3 stars

=head2 Example 3

    Input: $str = "Hello", $width = 9
    Output: "**Hello**"

    Text length = 5, Width = 9
    Need 4 padding characters total
    Left padding: 2 stars, Right padding: 2 stars

=head2 Example 4

    Input: $str = "Perl", $width = 4
    Output: "Perl"

    No padding needed

=head2 Example 5

    Input: $str = "A", $width = 7
    Output: "***A***"

    Text length = 1, Width = 7
    Need 6 padding characters total
    Left padding: 3 stars, Right padding: 3 stars

=head2 Example 6

    Input: $str = "", $width = 5
    Output: "*****"

    Text length = 0, Width = 5
    Entire output is padding

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [["Hi",    5], "*Hi**",      "Example 1"],
    [["Code", 10], "***Code***", "Example 2"],
    [["Hello", 9], "**Hello**",  "Example 3"],
    [["Perl",  4], "Perl",       "Example 4"],
    [["A",     7], "***A***",    "Example 5"],
    [["",      5], "*****",      "Example 6"],
];

sub text_justifier
{
    my $str   = $_[0]->[0];
    my $width = $_[0]->[1];

    my $len = length($str);

    return $str if $len >= $width;

    my $padding = $width - $len;
    my $lpadding = int($padding / 2);
    my $rpadding = $padding - $lpadding;

    return ('*' x $lpadding) . $str . ('*' x $rpadding);
}

for (@$cases) {
    is(text_justifier($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
