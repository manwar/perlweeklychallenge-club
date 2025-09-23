#!/usr/bin/env perl
#
=head1 Task 2: Ascending Numbers

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, is a list of tokens separated by a single space.
Every token is either a positive number consisting of digits 0-9 with no
leading zeros, or a word consisting of lowercase English letters.

Write a script to check if all the numbers in the given string are strictly
increasing from left to right.

=head2 Example 1

    Input: $str = "The cat has 3 kittens 7 toys 10 beds"
    Output: true

    Numbers 3, 7, 10 - strictly increasing.

=head2 Example 2

    Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
    Output: false

=head2 Example 3

    Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
    Output: true

=head2 Example 4

    Input: $str = 'Bob has 10 cars 10 bikes'
    Output: false

=head2 Example 5

    Input: $str = 'Zero is 0 one is 1 two is 2'
    Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ['The cat has 3 kittens 7 toys 10 beds',      1, 'Example 1'],
    ['Alice bought 5 apples 2 oranges 9 bananas', 0, 'Example 2'],
    ['I ran 1 mile 2 days 3 weeks 4 months',      1, 'Example 3'],
    ['Bob has 10 cars 10 bikes',                  0, 'Example 4'],
    ['Zero is 0 one is 1 two is 2',               1, 'Example 5'],
];

sub ascending_numbers
{
    my $str = shift;
    my @tokens = grep /[0-9]/, split /\s+/, $str;

    for (my $i = 1; $i < @tokens; $i++) {
        return 0 if $tokens[$i] <= $tokens[$i-1];
    }
    return 1;
}

for (@$cases) {
    is(ascending_numbers($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
