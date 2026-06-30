#!/usr/bin/env perl
#
=head1 Task 2: Reverse Degree

Submitted by: Mohammad Sajid Anwar

You are given a string.  Write a script to find the reverse degree of the given
string.  For each character, multiply its position in the reversed alphabet
('a' = 26, 'b' = 25, ..., 'z' = 1) with its position in the string. Sum these
products for all characters in the string to get the reverse degree.

=head2 Example 1

    Input: $str = "z"
    Output: 1

    Reverse alphabet value of "z" is 1.
    Position 1: 1 x 1
    Sum of product: 1

=head2 Example 2

    Input: $str = "a"
    Output: 26

    Reverse alphabet value of "a" is 26.
    Position 1: 1 x 26
    Sum of product: 26

=head2 Example 3

    Input: $str = "bbc"
    Output: 147

    Reverse alphabet value of "b" is 25 and "c" is 24.
    Position 1: 1 x 25
    Position 2: 2 x 25
    Position 3: 3 x 24
    Sum of product: 25 + 50 + 72 => 147

=head2 Example 4

    Input: $str = "racecar"
    Output: 560

    Reverse alphabet value of "r" is 9, "a" is 26, "c" is 24 and "e" is 24.
    Position 1: 1 x 9
    Position 2: 2 x 26
    Position 3: 3 x 24
    Position 4: 4 x 22
    Position 5: 5 x 24
    Position 6: 6 x 26
    Position 7: 7 x 9
    Sum of product: 9 + 52 + 72 + 88 + 120 + 156 + 63

=head2 Example 5

    Input: $str = "zyx"
    Output: 14

    Reverse alphabet value of "z" is 1, "y" is 2 and "x" is 3.
    Position 1: 1 x 1
    Position 2: 2 x 2
    Position 3: 3 x 3
    Sum of product: 1 + 4 + 9

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {str => "z",       out =>   1, name => "Example 1"},
    {str => "a",       out =>  26, name => "Example 2"},
    {str => "bbc",     out => 147, name => "Example 3"},
    {str => "racecar", out => 560, name => "Example 4"},
    {str => "zyx",     out =>  14, name => "Example 5"},
);

sub reverse_degree
{
    my $str = shift;

    my $sum = 0;
    my $len = length($str);
    for my $i (0 .. $len - 1) {
        my $rev_val = 26 - (ord(substr($str, $i, 1)) - ord('a'));
        $sum += ($i + 1) * $rev_val;
    }
    return $sum;

}

for my $case (@cases) {
    my $got = reverse_degree($case->{str});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
