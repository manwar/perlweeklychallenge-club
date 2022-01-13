#!/usr/bin/perl

=head1

Week 141:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-141

Task #1: Number Divisors

    Write a script to find lowest 10 positive integers having exactly 8 divisors.

=cut

use strict;
use warnings;
use Test::More;
use Test::Deep;

is_deeply(
    number_divisors(10, 8),
    [24, 30, 40, 42, 54, 56, 66, 70, 78, 88],
    'Example 1'
);

done_testing;

sub number_divisors {
    my ($count, $number) = @_;

    my @numbers = ();
    my $i = 1;
    while (@numbers < $count) {

        my @divisors = ();
        foreach my $j (1 .. $i) {
            if ($i % $j == 0) {
                push @divisors, $j;
            }
        }

        if (@divisors == $number) {
            push @numbers, $i;
        }

        $i++;
    }

    return \@numbers;
}
