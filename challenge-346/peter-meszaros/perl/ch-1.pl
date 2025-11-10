#!/usr/bin/env perl
#
=head1 Task 1: Longest Parenthesis

Submitted by: Mohammad Sajid Anwar

You are given a string containing only ( and ).

Write a script to find the length of the longest valid parenthesis.

=head2 Example 1

    Input: $str = '(()())'
    Output: 6

    Valid Parenthesis: '(()())'

=head2 Example 2

    Input: $str = ')()())'
    Output: 4

    Valid Parenthesis: '()()' at positions 1-4.

=head2 Example 3

    Input: $str = '((()))()(((()'
    Output: 8

    Valid Parenthesis: '((()))()' at positions 0-7.

=head2 Example 4

    Input: $str = '))))((()('
    Output: 2

    Valid Parenthesis: '()' at positions 6-7.

=head2 Example 5

    Input: $str = '()(()'
    Output: 2

    Valid Parenthesis: '()' at positions 0-1 and 3-4.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ['(()())',        6, "Example 1"],
    [')()())',        4, "Example 2"],
    ['((()))()(((()', 8, "Example 3"],
    ['))))((()(',     2, "Example 4"],
    ['()(()',         2, "Example 5"],
];

sub longest_parenthesis
{
    my $s = shift;
    my @stack = (-1);
    my $max_length = 0;

    for (my $i = 0; $i < length($s); $i++) {
        my $char = substr($s, $i, 1);
        if ($char eq '(') {
            push @stack, $i;
        } else {
            pop @stack;
            if (@stack) {
                my $length = $i - $stack[-1];
                $max_length = $length if $length > $max_length;
            } else {
                push @stack, $i;
            }
        }
    }
    return $max_length;
}

for (@$cases) {
    is(longest_parenthesis($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
