#!/usr/bin/perl

=head1

Week 177:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-177

Task #1: Damm Algorigthm

    You are given a positive number, $n.

    Write a script to validate the given number against the included
    check digit.

=cut

use v5.36;
use Test2::V0;

ok  is_valid_check_digit(5724), 'example 1';
ok !is_valid_check_digit(5727), 'example 2';

done_testing;

#
#
# METHOD

sub is_valid_check_digit($n) {
    my $op_table = [
        [ 0, 3, 1, 7, 5, 9, 8, 6, 4, 2 ],
        [ 7, 0, 9, 2, 1, 5, 4, 8, 6, 3 ],
        [ 4, 2, 0, 6, 8, 7, 1, 3, 5, 9 ],
        [ 1, 7, 5, 0, 9, 8, 3, 4, 2, 6 ],
        [ 6, 1, 2, 3, 0, 4, 5, 9, 7, 8 ],
        [ 3, 6, 7, 4, 2, 0, 9, 5, 8, 1 ],
        [ 5, 8, 6, 9, 7, 2, 0, 1, 3, 4 ],
        [ 8, 9, 4, 5, 3, 6, 2, 0, 1, 7 ],
        [ 9, 4, 3, 8, 6, 1, 7, 2, 0, 5 ],
        [ 2, 5, 8, 1, 4, 3, 6, 7, 9, 0 ],
    ];

    my @n = split //, $n;
    my $c = pop @n;
    my $i = 0;
    foreach my $j (@n) {
        $i = $op_table->[$i][$j];
    }

    return $i == $c;
}
