#!/usr/bin/env perl
#
=head1
Task 1: Thousand Separator

Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int.
Write a script to add thousand separator, , and return as string.

=head2 Example 1

    Input: $int = 123
    Output: "123"

=head2 Example 2

    Input: $int = 1234
    Output: "1,234"

=head2 Example 3

    Input: $int = 1000000
    Output: "1,000,000"

=head2 Example 4

    Input: $int = 1
    Output: "1"

=head2 Example 5

    Input: $int = 12345
    Output: "12,345"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [    123,       "123", "Example 1"],
    [   1234,     "1,234", "Example 2"],
    [1000000, "1,000,000", "Example 3"],
    [      1,         "1", "Example 4"],
    [  12345,    "12,345", "Example 5"],
];

sub thousand_separator
{
    my $int = shift;
    my $str = reverse $int;
    $str =~ s/(\d{3})(?=\d)/$1,/g;
    return reverse $str;
}

for (@$cases) {
    is(thousand_separator($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
