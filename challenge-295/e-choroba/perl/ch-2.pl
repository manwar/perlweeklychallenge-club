#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub jump_game(@ints) {
    my %reachable_in_jump = (0 => 0);
    for my $i (0 .. $#ints - 1) {
        next unless exists $reachable_in_jump{$i};

        for my $j (1 .. $ints[$i]) {
            return $reachable_in_jump{$i} + 1 if $i + $j >= $#ints;

            $reachable_in_jump{ $i + $j } //= $reachable_in_jump{$i} + 1;
        }
    }
    return -1
}

use Test::More tests => 3;

is jump_game(2, 3, 1, 1, 4), 2, 'Example 1';
is jump_game(2, 3, 0, 4), 2, 'Example 2';
is jump_game(2, 0, 0, 4), -1, 'Example 3';
