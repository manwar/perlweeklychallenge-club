#!/usr/bin/env perl
#
=head1 Task 2: Group Division

Submitted by: Mohammad Sajid Anwar

You are given a string, group size and filler character.  Write a script to
divide the string into groups of given size. In the last group if the string
doesn't have enough characters remaining fill with the given filler character.

=head2 Example 1

    Input: $str = "RakuPerl", $size = 4, $filler = "*"
    Output: ("Raku", "Perl")

=head2 Example 2

    Input: $str = "Python", $size = 5, $filler = "0"
    Output: ("Pytho", "n0000")

=head2 Example 3

    Input: $str = "12345", $size = 3, $filler = "x"
    Output: ("123", "45x")

=head2 Example 4

    Input: $str = "HelloWorld", $size = 3, $filler = "_"
    Output: ("Hel", "loW", "orl", "d__")

=head2 Example 5

    Input: $str = "AI", $size = 5, $filler = "!"
    Output: "AI!!!"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [["RakuPerl",   4, "*"], ["Raku",  "Perl"],              'Example 1'],
    [["Python",     5, "0"], ["Pytho", "n0000"],             'Example 2'],
    [["12345",      3, "x"], ["123",   "45x"],               'Example 3'],
    [["HelloWorld", 3, "_"], ["Hel",   "loW", "orl", "d__"], 'Example 4'],
    [["AI",         5, "!"], ["AI!!!"],                      'Example 5'],
];

sub group_division
{
    my $str    = $_[0]->[0];
    my $size   = $_[0]->[1];
    my $filler = $_[0]->[2];

    my @result;
    while (length($str) > 0) {
        my $group = substr($str, 0, $size, '');
        $group .= $filler x ($size - length($group)) if length($group) < $size;
        push @result, $group;
    }
    return \@result;
}

for (@$cases) {
    is(group_division($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
