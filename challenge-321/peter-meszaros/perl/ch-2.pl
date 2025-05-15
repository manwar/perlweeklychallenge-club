#!/usr/bin/env perl
#
=head1 Task 2: Backspace Compare

Submitted by: Mohammad Sajid Anwar

You are given two strings containing zero or more #.

Write a script to return true if the two given strings are same by treating #
as backspace.

=head2 Example 1

    Input: $str1 = "ab#c"
           $str2 = "ad#c"
    Output: true

    For first string,  we remove "b" as it is followed by "#".
    For second string, we remove "d" as it is followed by "#".
    In the end both strings became the same.

=head2 Example 2

    Input: $str1 = "ab##"
           $str2 = "a#b#"
    Output: true

=head2 Example 3

    Input: $str1 = "a#b"
           $str2 = "c"
    Output: false

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["ab#c", "ad#c"], 1, "Example 1"],
    [["ab##", "a#b#"], 1, "Example 2"],
    [["a#b",  "c"],    0, "Example 3"],
];

sub backspace_compare
{
    my $str1 = $_[0]->[0];
    my $str2 = $_[0]->[1];
    my $regex = qr/[^#]#/;

    while ($str1 =~ s/$regex//) {
    }
    while ($str2 =~ s/$regex//) {
    }

    return $str1 eq $str2 ? 1 : 0;
}

for (@$cases) {
    is(backspace_compare($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
