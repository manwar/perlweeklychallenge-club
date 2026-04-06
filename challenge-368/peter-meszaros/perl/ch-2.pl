#!/usr/bin/env perl
#
=head1 Task 2: Big and Little Omega

Submitted by: Roger Bell_West

You are given a positive integer $number and a mode flag $mode. If the mode
flag is zero, calculate little omega (the count of all distinct prime factors
of that number). If it is one, calculate big omega (the count of all prime
factors including duplicates).

=head2 Example 1

    Input: $number = 100061
           $mode = 0
    Output: 3

    Prime factors are 13, 43, 179. Count is 3.

=head2 Example 2

    Input: $number = 971088
           $mode = 0
    Output: 3

    Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.

=head2 Example 3

    Input: $number = 63640
           $mode = 1
    Output: 6

    Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.

=head2 Example 4

    Input: $number = 988841
           $mode = 1
    Output: 2

=head2 Example 5

    Input: $number = 211529
           $mode = 0
    Output: 2

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[100061, 0], 3, "Example 1"],
    [[971088, 0], 3, "Example 2"],
    [[ 63640, 1], 6, "Example 3"],
    [[988841, 1], 2, "Example 4"],
    [[211529, 0], 2, "Example 5"],
];

sub big_and_little_omega
{
    sub prime_factors
    {
        my $n = shift;
        my @factors;

        for (my $i = 2; $i <= sqrt($n); $i++) {
            while ($n % $i == 0) {
                push @factors, $i;
                $n /= $i;
            }
        }
        push @factors, $n if $n > 1;

        return @factors;
    }

    my $number = $_[0]->[0];
    my $mode   = $_[0]->[1];

    my @big_omega = prime_factors($number);
    my %little_omega = map { $_ => true } @big_omega;

    return scalar($mode ? @big_omega : keys %little_omega);
}

for (@$cases) {
    is(big_and_little_omega($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
