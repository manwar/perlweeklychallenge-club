#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub sort_letters($letters, $weights) {
    return join "",
        @$letters[ sort { $weights->[$a] <=> $weights->[$b] } 0 .. $#$weights ]
}

use Test::More tests => 3;

is sort_letters(['R', 'E', 'P', 'L'], [3, 2, 1, 4]), 'PERL', 'Example 1';
is sort_letters(['A', 'U', 'R', 'K'], [2, 4, 1, 3]), 'RAKU', 'Example 2';
is sort_letters(['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3]),
    'PYTHON', 'Example 3';
