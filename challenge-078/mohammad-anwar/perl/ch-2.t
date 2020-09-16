#!/usr/bin/perl

#
# Perl Weekly Challenge - 078
#
# Task #2: Left Rotation
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078
#

use strict;
use warnings;
use Test::More;
use Test::Deep;

is_deeply(left_rotation([10, 20, 30, 40, 50], [3, 4]),
          [[40, 50, 10, 20, 30], [50, 10, 20, 30, 40]],
          "testing example 1");

is_deeply(left_rotation([7, 4, 2, 6, 3], [1, 3, 4]),
          [[4, 2, 6, 3, 7], [6, 3, 7, 4, 2], [3, 7, 4, 2, 6]],
          "testing example 2");

done_testing;

#
#
# METHODS

sub left_rotation {
    my ($source, $index) = @_;

    my $left_rotation = [];
    foreach my $i (@$index) {
        my $array = [];
        foreach my $j ($i .. $#$source) {
            push @$array, $source->[$j];
        }
        if ($i > 0) {
            foreach my $k (0 .. $i-1) {
                push @$array, $source->[$k];
            }
        }
        push @$left_rotation, $array;
    }

    return $left_rotation;
}
