#!/usr/bin/env perl
#
=head1 Task 2: Armstrong Number

Submitted by: Mohammad Sajid Anwar

You are given two integers, $base and $limit.  Write a script to find all
Armstrong numbers in base $base that are less than $limit.

If raising each of the digits of a nonnegative integer to the power of the
total number of digits, then taking the sum, equals the original number, it is
an Armstrong number.

=head2 Example 1

    Input: $base = 10, $limit = 1000
    Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407)

=head2 Example 2

    Input: $base = 7, $limit = 1000
    Output: (0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250)

=head2 Example 3

    Input: $base = 16, $limit = 1000
    Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645)

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {base => 10, limit => 1000,
        expected => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407],
        label => 'Example 1'},
    {base => 7, limit => 1000,
        expected => [0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250],
        label => 'Example 2'},
    {base => 16, limit => 1000,
        expected => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645],
        label => 'Example 3'},
);

sub armstrong_number
{
    my $base = shift;
    my $limit = shift;

    my $result = [];
    for my $num (0 .. $limit) {
        my $n = $num;
        my @digits;
        my $power = 0;
        while ($n > 0) {
            push @digits, $n % $base;
            $power++;
            $n = int($n / $base);
        }

        my $sum = 0;
        $sum += $_ ** $power for @digits;
        push @$result, $num if $sum == $num;
    }
    return $result;
}

plan(tests => scalar @cases);
for my $case (@cases) {
    my $got = armstrong_number($case->{base}, $case->{limit});
    is($got, $case->{expected}, $case->{label});
}
done_testing();

exit 0;
