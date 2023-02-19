#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use Test2::V0;

=head1 AUTHORS

Vamsi Meenavilli

=head1 DESCRIPTION

     Week 204:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-204

    Task 1: Monotonic Array
    Submitted by: Mohammad S Anwar
    You are given an array of integers.

    Write a script to find out if the given array is Monotonic. Print 1 if it is otherwise 0.

    An array is Monotonic if it is either monotone increasing or decreasing.

=cut


ok(IsMonotonicArray(1,2,2,3), 'Test Case 1 Failed.');
ok(!IsMonotonicArray(1,3,2), 'Test Case 2 Failed.');
ok(IsMonotonicArray(6,5,5,4), 'Test Case 2 Failed.');

sub IsMonotonicArray {
    my @array = @_;

    my $array_size = scalar(@array);
    my ($increement, $decreement) = (1, 1);

    for (my $i = 0; $i < $array_size - 1; $i++) {
        $increement = 0 unless $array[$i] >= $array[$i + 1];
        $decreement = 0 unless $array[$i] <= $array[$i + 1];
        return 0 unless $increement || $decreement;
    }

    return 1;
}

done_testing();
