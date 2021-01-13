#!/usr/bin/perl

#
# Perl Weekly Challenge - 078
#
# Task #1: Leader Element
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078
#

use strict;
use warnings;
use Test::More;
use Test::Deep;
use List::Util qw(max);

is_deeply([leader_elements([9, 10, 7, 5, 6, 1])],
          [10, 7, 6, 1],
          "testing example 1");

is_deeply([leader_elements([3, 4, 5])],
          [5],
          "testing example 2");

done_testing;

#
#
# METHOD

sub leader_elements {
    my ($list) = @_;

    my @leaders = ();
    my $i       = 0;
    my @array   = @$list;
    foreach my $n (@array) {
        if ($i == $#array) {
            push @leaders, $n;
        }
        else {
            push @leaders, $n
                if ($n > max(@array[$i+1 .. $#array]));
        }
        $i++;
    }

    return @leaders;
}
