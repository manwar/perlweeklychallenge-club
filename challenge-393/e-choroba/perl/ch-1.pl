#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub pythagoras_multiplied($n) {
    my $count = 0;
    for my $A (1 .. $n - 2) {
        for my $B (1 .. $n - 2) {
            my $c = sqrt($A * $A + $B * $B);
            ++$count if $c <= $n && $c == int $c;
        }
    }
    return $count
}

use Test::More tests => 5;

is pythagoras_multiplied(20), 12, 'Example 1';
is pythagoras_multiplied(7), 2, 'Example 2';
is pythagoras_multiplied(1), 0, 'Example 3';
is pythagoras_multiplied(15), 8, 'Example 4';
is pythagoras_multiplied(30), 22, 'Example 5';
