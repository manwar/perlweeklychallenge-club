#!/usr/bin/env perl
#
=head1 Task 2: Luhn's Algorithm

Submitted by: Andrezgz

You are given a string $str containing digits (and possibly other characters
which can be ignored). The last digit is the payload; consider it separately.
Counting from the right, double the value of the first, third, etc. of the
remaining digits.

For each value now greater than 9, sum its digits.

The correct check digit is that which, added to the sum of all values, would
bring the total mod 10 to zero.

Return true if and only if the payload is equal to the correct check digit.

It was originally posted on reddit.

=head1 Example 1

    Input: "17893729974"
    Output: true

    Payload is 4.

    Digits from the right:

    7 * 2 = 14, sum = 5
    9 = 9
    9 * 2 = 18, sum = 9
    2 = 2
    7 * 2 = 14, sum = 5
    3 = 3
    9 * 2 = 18, sum = 9
    8 = 8
    7 * 2 = 14, sum = 5
    1 = 1

    Sum of all values = 56, so 4 must be added to bring the total mod 10 to zero. The payload is indeed 4.

=head1 Example 2

    Input: "4137 8947 1175 5904"
    Output: true

=head2 Example 3

    Input: "4137 8974 1175 5904"
    Output: false

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ['17893729974',         1, 'Example 1'],
    ['4137 8947 1175 5904', 1, 'Example 2'],
    ['4137 8974 1175 5904', 0, 'Example 3'],
];

sub luhns_algorithm
{
    my $str = shift;

    $str =~ s/\D//g;
    my @str = split '', $str;

    my $sum = 0;
    for my $i (1 .. $#str) {
        if ($i % 2) {
            my $v = $str[-1-$i] * 2;
            $sum += (length($v) == 2 ? substr($v, 0, 1) + substr($v, 1, 1) : $v);
        } else {
            $sum += $str[-1-$i];
        }
    }
    
    return (($sum + $str[-1]) % 10) ? 0 : 1;
}

for (@$cases) {
    is(luhns_algorithm($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
