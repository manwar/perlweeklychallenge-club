#!/usr/bin/perl

=head1

Week 188:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

Task #2: Total Zero

    You are given two positive integers $x and $y.

    Write a script to find out the number of operations needed to
    make both ZERO. Each operator is made up either of the following:

        $x = $x - $y if $x >= $y

        or

        $y = $y - $x if $y >= $x

=cut

use v5.36;
use Test2::V0;

is total_zero(5, 4), 5, 'example 1';
is total_zero(4, 6), 3, 'Example 2';
is total_zero(2, 5), 4, 'Example 3';
is total_zero(3, 1), 3, 'Example 4';
is total_zero(7, 4), 5, 'Example 5';

done_testing;

#
#
# METHOD

sub total_zero($x, $y) {
    my $count = 0;
    while ($x > 0 && $y > 0) {
        ($x >= $y)?($x = $x - $y):($y = $y - $x);
        $count++;
    }

    return $count;
}
