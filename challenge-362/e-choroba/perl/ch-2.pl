#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Lingua::EN::Numbers qw{ num2en };

sub spellbound_sorting(@integers) {
    return map $_->[1],
           sort { $a->[0] cmp $b->[0] }
           map [num2en($_), $_],
           @integers
}

use Test2::V0;
plan(5);

is [spellbound_sorting(6, 7, 8, 9 ,10)], [8, 9, 7, 6, 10], 'Example 1';
is [spellbound_sorting(-3, 0, 1000, 99)], [-3, 99, 1000, 0], 'Example 2';
is [spellbound_sorting(1, 2, 3, 4, 5)], [5, 4, 1, 3, 2], 'Example 3';
is [spellbound_sorting(0, -1, -2, -3, -4)], [-4, -1, -3, -2, 0], 'Example 4';
is [spellbound_sorting(100, 101, 102)], [100, 101, 102], 'Example 5';
