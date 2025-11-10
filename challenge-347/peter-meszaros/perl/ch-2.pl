#!/usr/bin/env perl
#
=head1 Task 2: Format Phone Number

Submitted by: Mohammad Sajid Anwar

You are given a phone number as a string containing digits, space and dash only.

Write a script to format the given phone number using the below rules:

    1. Removing all spaces and dashes
    2. Grouping digits into blocks of length 3 from left to right
    3. Handling the final digits (4 or fewer) specially:
       - 2 digits: one block of length 2
       - 3 digits: one block of length 3
       - 4 digits: two blocks of length 2
    4. Joining all blocks with dashes

=head2 Example 1

    Input: $phone = "1-23-45-6"
    Output: "123-456"

=head2 Example 2

    Input: $phone = "1234"
    Output: "12-34"

=head2 Example 3

    Input: $phone = "12 345-6789"
    Output: "123-456-789"

=head2 Example 4

    Input: $phone = "123 4567"
    Output: "123-45-67"

=head2 Example 5

    Input: $phone = "123 456-78"
    Output: "123-456-78"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["1-23-45-6",   "123-456",     "Example 1"],
    ["1234",        "12-34",       "Example 2"],
    ["12 345-6789", "123-456-789", "Example 3"],
    ["123 4567",    "123-45-67",   "Example 4"],
    ["123 456-78",  "123-456-78",  "Example 5"],
];

sub format_phone_number
{
    my $phone = shift;
    $phone =~ s/[\s-]//g;
    my @digits = split //, $phone;

    my @blocks;
    while (@digits) {
        if (@digits == 4) {
            push @blocks, join('', splice(@digits, 0, 2)),
                          join('', splice(@digits, 0, 2));
        } elsif (@digits == 2) {
            push @blocks, join('', splice(@digits, 0, 2));
        } else {
            push @blocks, join('', splice(@digits, 0, 3));
        }
    }
    return join('-', @blocks);
}

for (@$cases) {
    is(format_phone_number($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
