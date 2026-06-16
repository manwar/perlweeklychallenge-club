#!/usr/bin/env perl
#
=head1 Task 1: Second Largest Digit

Submitted by: Mohammad Sajid Anwar

You are given an alphanumeric string.  Write a script to find the second
largest distinct digit in the given string. Return -1 if none found.

=head2 Example 1

    Input: $str = "aaaaa77777"
    Output: -1

    The only digit in the given string is 7 and there is no second digit.

=head2 Example 2

    Input: $str = "abcde"
    Output: -1

    No numerical digits in the given string.

=head2 Example 3

    Input: $str = "9zero8eight7seven9"
    Output: 8

=head2 Example 4

    Input: $str = "xyz9876543210"
    Output: 8

=head2 Example 5

    Input: $str = "4abc4def2ghi8jkl2"
    Output: 4

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["aaaaa77777",        -1, "Example 1"],
    ["abcde",             -1, "Example 2"],
    ["9zero8eight7seven9", 8, "Example 3"],
    ["xyz9876543210",      8, "Example 4"],
    ["4abc4def2ghi8jkl2",  4, "Example 5"],
];

sub second_largest_digit
{
    my $str = shift;

    my %digits;
    $digits{$_}++ for $str =~ /(\d)/g;
    my @sorted_digits = sort keys %digits;

    return @sorted_digits < 2 ? -1 : $sorted_digits[-2];
}

for (@$cases) {
    is(second_largest_digit($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
