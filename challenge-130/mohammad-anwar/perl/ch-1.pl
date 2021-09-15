#!/usr/bin/perl

=head1

Week 130:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-130/

Task #1: Odd Number

    You are given an array of positive integers, such that all the
    numbers appear even number of times except one number.

    Write a script to find that integer.

=cut

use strict;
use warnings;

use Test::More;

is(odd_number(2, 5, 4, 4, 5, 5, 2), 5);
is(odd_number(1, 2, 3, 4, 3, 2, 1, 4, 4), 4);

done_testing;

sub odd_number {
    my @numbers = @_;

    my %count_of = ();
    map { $count_of{$_}++ } @numbers;

    foreach my $number (keys %count_of) {
        return $number if $count_of{$number} % 2 == 1;;
    }
}
