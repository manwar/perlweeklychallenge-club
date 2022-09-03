#!/usr/bin/perl

=head1

Week 180:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-180

Task #1: Trim List

    You are given list of numbers, @n and an integer $i.

    Write a script to trim the given list where element is less than
    or equal to the given integer.

=cut

use v5.36;
use Test2::V0;

is trim_list(3, [1, 4, 2, 3, 5]),       [4, 5],       'Example 1';
is trim_list(4, [9, 0, 6, 2, 3, 8, 5]), [9, 6, 8, 5], 'Example 2';

done_testing;

#
#
# METHOD

sub trim_list($i, $n) {
    my @l = ();
    foreach (@$n) {
        push @l, $_ if $_ > $i;
    }

    return \@l;
}
