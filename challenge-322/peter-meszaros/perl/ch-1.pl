#!/usr/bin/env perl
#
=head1 Task 1: String Format

Submitted by: Mohammad Sajid Anwar

You are given a string and a positive integer.

Write a script to format the string, removing any dashes, in groups of size
given by the integer. The first group can be smaller than the integer but
should have at least one character. Groups should be separated by dashes.

=head2 Example 1

    Input: $str = "ABC-D-E-F", $i = 3
    Output: "ABC-DEF"

=head2 Example 2

    Input: $str = "A-BC-D-E", $i = 2
    Output: "A-BC-DE"

=head2 Example 3

    Input: $str = "-A-B-CD-E", $i = 4
    Output: "A-BCDE"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["ABC-D-E-F", 3], "ABC-DEF", "Example 1"],
    [["A-BC-D-E",  2], "A-BC-DE", "Example 2"],
    [["-A-B-CD-E", 4], "A-BCDE",  "Example 3"],
];

sub string_format
{
    my $str = $_[0]->[0];
    my $i = $_[0]->[1];

    $str =~ s/-//g;
    my @res;
    while ($str =~ s/.{1,$i}$//) {
        unshift @res, $&;
    }

    return join('-', @res);
}

for (@$cases) {
    is(string_format($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
