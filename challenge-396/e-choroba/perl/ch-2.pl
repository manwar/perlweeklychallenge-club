#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );
use builtin qw{ true false };

{   my @cmp = (-1, 1, -1);
    sub trionic_array(@arr) {
        my $part = 0;
        for my $i (1 .. $#arr) {
            return if $part > $#cmp;

            ++$part, redo if ($arr[ $i - 1 ] <=> $arr[$i]) != $cmp[$part];
        }
        return $part == $#cmp
    }
}

use Test2::V0;
plan(5 + 4);

is trionic_array(1, 3, 5, 4, 2, 6, 8), bool(true), 'Example 1';
is trionic_array(1, 4, 4, 2, 1, 3, 5), bool(false), 'Example 2';
is trionic_array(2, 10, 3, 1, 9), bool(true), 'Example 3';
is trionic_array(1, 2, 3, 4, 3, 2, 1), bool(false), 'Example 4';
is trionic_array(1, 3, 6, 4, 2, 7, 8, 4), bool(false), 'Example 5';

is trionic_array(), bool(false), 'Empty';
is trionic_array(1), bool(false), 'Single element';
is trionic_array(1, 2), bool(false), 'Two elements';
is trionic_array(1, 2, 1, 2), bool(true), 'Shortest';
