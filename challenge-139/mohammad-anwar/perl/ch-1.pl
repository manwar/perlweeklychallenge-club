#!/usr/bin/perl

=head1

Week 139:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-139

Task #1: JortSort

    You are given a list of numbers.

    Write a script to implement JortSort. It should return true/false depending if the given list of numbers are already sorted.

=cut

use strict;
use warnings;

use Test::More;

is(jortsort(1,2,3,4,5), 1, 'Example 1');
is(jortsort(1,3,2,4,5), 0, 'Example 2');

done_testing;

sub jortsort {
    my (@n) = @_;

    my @s = sort @n;
    foreach my $i (0 .. @n-1) {
        return 0 if ($s[$i] != $n[$i]);
    }

    return 1;
}
