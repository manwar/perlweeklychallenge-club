#!/usr/bin/env perl
#
=head1 Task 2: Find K-Beauty

Submitted by: Mohammad Sajid Anwar

You are given a number and a digit (k).  Write a script to find the K-Beauty of
the given number. The K-Beauty of an integer number is defined as the number of
substrings of given number when it is read as a string has length of 'k' and is
a divisor of given number.

=head2 Example 1

    Input: $num = 240, $k = 2
    Output: 2

    Substring with length 2:
    24: 240 is divisible by 24
    40: 240 is divisible by 40

=head2 Example 2

    Input: $num = 1020, $k = 2
    Output: 3

    Substring with length 2:
    10: 240 is divisible by 10
    02: 240 is divisible by 2
    20: 240 is divisible by 20

=head2 Example 3

    Input: $num = 444, $k = 2
    Output: 0

    Substring with length 2:
    First "44": 444 is not divisible by 44
    Second "44": 444 is not divisible by 44

=head2 Example 4

    Input: $num = 17, $k = 2
    Output: 1

    Substring with length 2:
    17: 17 is divisible by 17

=head2 Example 5

    Input: $num = 123, $k = 1
    Output: 2

    Substring with length 1:
    1: 123 is divisible by 1
    2: 123 is not divisible by 2
    3: 123 is divisible by 3

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[ 240, 2], 2, "Example 1"],
    [[1020, 2], 3, "Example 2"],
    [[ 444, 2], 0, "Example 3"],
    [[  17, 2], 1, "Example 4"],
    [[ 123, 1], 2, "Example 5"],
];

sub find_k_beauty
{
    my $num = $_[0]->[0];
    my $k   = $_[0]->[1];

    my $count = 0;
    for (my $i = 0; $i <= length($num) - $k; $i++) {
        my $substr = substr($num, $i, $k);
        next if $substr == 0;
        $count++ if $num % $substr == 0;
    }
    return $count;
}

for (@$cases) {
    is(find_k_beauty($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
