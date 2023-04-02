#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

# What happens to zeroes? They don't move, but I interpret the rules
# in the following way: if any number tries to move into a zero, the
# zero explodes (see the additional tests).

sub number_collision(@list) {
    while (1) {
        my $changed;
        my @new = @list;
        for (my $i = 0; $i <= $#list; ++$i) {
            if ($list[$i] > 0 && $i < $#list && $list[ $i + 1 ] <= 0) {
                @new[$i, $i + 1] = (
                    undef,
                    (undef, @list[$i, $i + 1])[
                        abs $list[$i] <=> abs $list[ $i + 1 ]]);
                ++$i;
                $changed = 1;
            } elsif ($list[$i] == 0 && $i < $#list && $list[ $i + 1 ] < 0) {
                @new[$i, $i + 1] = (undef, $list[ $i + 1 ]);
            }
        }
        @list = grep defined, @new;
        last unless $changed
    }
    return \@list
}

use Test2::V0;
plan 3 + 3;

is number_collision(2, 3, -1), [2, 3], 'Example 1';
is number_collision(3, 2, -4), [-4], 'Example 2';
is number_collision(1, -1), [], 'Example 3';

is number_collision(0, 0), [0, 0], 'Only zeroes';
is number_collision(1, 0), [1], "Zeroes don't move positive";
is number_collision(0, -1), [-1], "Zeroes don't move negative";
