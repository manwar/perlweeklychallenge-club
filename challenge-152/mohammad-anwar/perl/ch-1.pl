#!/usr/bin/perl

=head1

Week 152:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-152

Task #1: Triangle Sum Path

    You are given a triangle array.

    Write a script to find the minimum sum path from top to bottom.

=cut

use strict;
use warnings;
use Test::More;
use List::Util qw(min);

is(triangle_sum_path_1([ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]), 8, 'Example 1 (option 1)');
is(triangle_sum_path_1([ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]), 9, 'Example 2 (option 1)');

is(triangle_sum_path_2([ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]), 8, 'Example 1 (option 2)');
is(triangle_sum_path_2([ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]), 9, 'Example 2 (option 2)');

done_testing;

#
#
# METHOD

sub triangle_sum_path_1 {
    my ($triangle_array) = @_;

    my $sum_path = 0;
    foreach my $row (@$triangle_array) {
        $sum_path += min @$row;
    }

    return $sum_path;
}

sub triangle_sum_path_2 {
    my ($triangle_array) = @_;

    my $sum_path = 0;
    $sum_path += min @$_ for @$triangle_array;;

    return $sum_path;
}
