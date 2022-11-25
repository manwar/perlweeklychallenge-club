#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw/sum uniq/;
use Test2::V0;

=head1 AUTHORS

Vamsi Meenavilli

=head1 DESCRIPTION

	https://theweeklychallenge.org/blog/perl-weekly-challenge-192

	Task 1: Equal Distribution
	Submitted by: Mohammad S Anwar
	You are given a list of integers greater than or equal to zero, @list.

	Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print -1.

	Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]

	1) You can only move a value of '1' per move
	2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell

=cut

is(equalDistribution([1, 0, 5]), 4, 'Example 1');
is(equalDistribution([0, 2, 0]), -1, 'Example 2');
is(equalDistribution([0, 3, 0]), 2, 'Example 3');

sub equalDistribution {
    my ($numbers_list) = @_;

    my $number_list_size = scalar(@$numbers_list);
    my $moves = 0;

    if (sum(@$numbers_list) % $number_list_size == 0) {
        while (scalar(uniq @$numbers_list) != 1) {
            my ($max_number_index) = getMaxNumberIndex($numbers_list, $number_list_size);
            my $before_max_number_index = $max_number_index - 1;
            my $after_max_number_index = $max_number_index + 1;

            if (
                $after_max_number_index >= $number_list_size
                || $numbers_list->[$before_max_number_index] <= $numbers_list->[$after_max_number_index]
            ) {
                $numbers_list->[$before_max_number_index] += 1;
            }
            else {
                $numbers_list->[$after_max_number_index] += 1
            }

            $numbers_list->[$max_number_index] -= 1;
            $moves += 1;
        }
    }
    else {
        $moves = -1;
    }

    return($moves);
}

sub getMaxNumberIndex {
    my ($numbers_list, $numbers_list_size) = @_;

    my ($max_number, $max_number_index) = (0, 0);

    for (my $i = 0; $i < $numbers_list_size; $i++) {
        if ($numbers_list->[$i] > $max_number) {
            $max_number = $numbers_list->[$i];
            $max_number_index = $i;
        }
    }

    return($max_number_index);
}

done_testing();
