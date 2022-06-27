#!/usr/bin/perl

=head1

Week 171:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-171

Task #1: Abundant Number

    Write a script to generate first 20 Abundant Odd Numbers.

=cut

use v5.36;
use Test2::V0;

sub divisor_sum($num) {
    my $sum = 0;
    foreach my $divisor (1 .. $num) {
        $sum += $divisor if $num % $divisor == 0;
    }
    return $sum;
}

sub abundant_odd_numbers($num) {
    my @aon = ();
    my $i   = 1;
    while (@aon < $num) {
        if (divisor_sum($i) > 2 * $i) {
            push @aon, $i;
        }
        $i += 2;
    }

    return \@aon;
}

is abundant_odd_numbers(20),
   [ 945, 1575, 2205, 2835, 3465, 4095, 4725, 5355, 5775, 5985,
    6435, 6615, 6825, 7245, 7425, 7875, 8085, 8415, 8505, 8925, ];

done_testing;
