#!/usr/bin/perl

=head1

Week 182:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-182

Task #1: Max Index

    You are given a list of integers.

    Write a script to find the index of the first biggest number in
    the list.

=cut

use v5.30;
use Test2::V0;

is max_index(5, 2, 9, 1, 7, 6), 2, 'Example 1';
is max_index(4, 2, 3, 1, 5, 0), 4, 'Example 2';

done_testing;

# METHOD

sub max_index {
    my $biggest_index=0;
    return unless scalar @_;
    for (my $i=0; $i<scalar (@_); $i++) {
        $biggest_index=$i if ($_[$i] > $_[$biggest_index]);
    }
    return $biggest_index;
}