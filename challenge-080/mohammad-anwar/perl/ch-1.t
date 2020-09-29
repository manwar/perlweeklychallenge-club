#!/usr/bin/perl

#
# Perl Weekly Challenge - 080
#
# Task #1: Smallest Positive Number
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-080
#

use strict;
use warnings;
use Test::More;

# examples from the task
is (smallest_positive_number([5, 2, -2, 0]), 1, "testing (5, 2, -2, 0)");
is (smallest_positive_number([1, 8, -1]),    2, "testing (1, 8, -1)");
is (smallest_positive_number([2, 0, -1]),    1, "testing (2, 0, -1)");

# some other test cases
is (smallest_positive_number([1, 2, 0]),     3, "testing (1, 2, 0)");
is (smallest_positive_number([-8, -7, -6]),  1, "testing (-8, -7, -6)");
is (smallest_positive_number([3, 4, -1, 1]), 2, "testing (3, 4, -1, 1)");
is (smallest_positive_number([2, 3, 7, 6, 8, -1, -10, 15]), 1, "testing (2, 3, 7, 6, 8, -1, -10, 15)");

done_testing;

#
#
# METHODS

sub smallest_positive_number {
    my ($arrayref) = @_;

    my @positive_numbers = sort(grep $_ > 0, @$arrayref);
    return 1 unless (@positive_numbers);

    my $i = 0;
    for my $n (1 .. $positive_numbers[-1]) {
        return $n if ($n < $positive_numbers[$i++]);
    }

    return $positive_numbers[-1]+1;
}
