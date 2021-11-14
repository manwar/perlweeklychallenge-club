#!/usr/bin/perl
use warnings;
use strict;

sub add_linked_lists {
    my ($l1, $l2) = @_;

    my $carry = 0;
    my $reversed;

    while (@$l1 || @$l2 || $carry) {
        my $e1 = shift @$l1 // 0;
        $l1    = shift @$l1 || [];
        my $e2 = shift @$l2 // 0;
        $l2    = shift @$l2 || [];

        my $r = $e1 + $e2 + $carry;
        $carry = int($r / 10);
        $r %= 10;

        $reversed = $reversed ? [$r, $reversed] : [$r];
    }
    return [] unless $reversed;

    my $result = [shift @$reversed];
    while (@$reversed) {
        $reversed =  shift @$reversed;
        $result   = [shift @$reversed, $result];
    }
    return $result
}

use Test2::V0;
plan 3;

is add_linked_lists([3, [2, [1]]],[1, [2, [3]]]),
    [4, [4, [4]]], 'Example 1';

is add_linked_lists([5, [4, [3, [2, [1]]]]], [5, [5, [6]]]),
    [0, [0, [0, [3, [1]]]]], 'Example 2';

is add_linked_lists([5, [9]], [5]),
    [0, [0, [1]]], 'Carry not lost even when both lists are exhausted';
