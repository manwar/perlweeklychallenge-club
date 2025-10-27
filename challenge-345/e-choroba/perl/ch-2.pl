#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub last_visitor(@ints) {
    my @seen;
    my @ans;
    my $negative = 0;
    for my $i (@ints) {
        if ($i > 0) {
            unshift @seen, $i;
            $negative = 0;
        } else {
            if ($negative < @seen) {
                push @ans, $seen[$negative];
            } else {
                push @ans, -1;
            }
            ++$negative;
        }
    }
    return @ans
}

use Test2::V0;
plan(5);

is [last_visitor(5, -1, -1)], [5, -1], 'Example 1';
is [last_visitor(3, 7, -1, -1, -1)], [7, 3, -1], 'Example 2';
is [last_visitor(2, -1, 4, -1, -1)], [2, 4, 2], 'Example 3';
is [last_visitor(10, 20, -1, 30, -1, -1)], [20, 30, 20], 'Example 4';
is [last_visitor(-1, -1, 5, -1)], [-1, -1, 5], 'Example 5';
