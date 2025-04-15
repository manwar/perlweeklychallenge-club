#!/usr/bin/env perl
#
=head1 Task 2: Friendly Strings

Submitted by: Mohammad Sajid Anwar

You are given two strings.

Write a script to return true if swapping any two letters in one string match
the other string, return false otherwise.

=head2 Example 1

    Input: $str1 = "desc", $str2 = "dsec"
    Output: true

=head2 Example 2

    Input: $str1 = "fuck", $str2 = "fcuk"
    Output: true

=head2 Example 3

    Input: $str1 = "poo", $str2 = "eop"
    Output: false

=head2 Example 4

    Input: $str1 = "stripe", $str2 = "sprite"
    Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["desc",   "dsec"],   1, "Example 1"],
    [["fuck",   "fcuk"],   1, "Example 2"],
    [["poo",    "eop"],    0, "Example 3"],
    [["stripe", "sprite"], 1, "Example 4"],
];

sub friendly_strings
{
    my ($str1, $str2) = @{$_[0]};

    return 0 if length($str1) != length($str2);

    my @rep;
    for my $i (0 .. length($str1) - 1) {
        my $c1 = substr($str1, $i, 1);
        my $c2 = substr($str2, $i, 1);
        if ($c1 ne $c2) {
            return 0 if @rep >= 2;
            push @rep, $i
        }
    }
    return 0 if @rep != 2;

    return substr($str1, $rep[0], 1) eq substr($str2, $rep[1], 1) && 
           substr($str1, $rep[1], 1) eq substr($str2, $rep[0], 1) ?
           1 : 0;
}

for (@$cases) {
    is(friendly_strings($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
