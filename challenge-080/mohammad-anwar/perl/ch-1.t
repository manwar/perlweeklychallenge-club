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

is (smallest_positive_number([1, 2, 0]),     3, "testing (1, 2, 0)");
is (smallest_positive_number([-8, -7, -6]),  1, "testing (-8, -7, -6)");
is (smallest_positive_number([3, 4, -1, 1]), 2, "testing (3, 4, -1, 1)");
is (smallest_positive_number([2, 3, 7, 6, 8, -1, -10, 15]), 1, "testing (2, 3, 7, 6, 8, -1, -10, 15)");


done_testing;

#
#
# METHODS

sub smallest_positive_number {
    my ($array) = @_;

    my %numbers = ();
    foreach my $n (@$array) {
        next unless $n > 0;
        $numbers{$n} = 1;
    }

    my $i = 0;
    foreach my $j (sort {$a <=> $b} keys %numbers) {
        next if (++$i == $j);
        return $i;
    }

    return ++$i;
}
