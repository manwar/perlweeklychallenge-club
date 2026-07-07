#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub same_row_column(@matrix) {
    my $expected = join ' ', 1 .. @matrix;
    for my $i (0 .. $#matrix) {
        return unless $expected eq join ' ',
                                   sort { $a <=> $b } @{ $matrix[$i] };
        return unless $expected eq join ' ',
                                   sort { $a <=> $b }
                                   map $matrix[$_][$i],
                                   0 .. $#matrix;
    }
    return 1
}

use Test2::V0 qw{ is bool plan };
plan(5 + 1);
use if ($] >= 5.036), builtin => qw( true false );
use if ($] <  5.036), constant => {true => 1, false => 0};

is same_row_column([1, 2, 3, 4],
                   [2, 3, 4, 1],
                   [3, 4, 1, 2],
                   [4, 1, 2, 3],), bool(true), 'Example 1';

is same_row_column([1]), bool(true), 'Example 2';

is same_row_column([1, 2, 5],
                   [5, 1, 2],
                   [2, 5, 1]), bool(false), 'Example 3';

is same_row_column([1, 2, 3],
                   [1, 2, 3],
                   [1, 2, 3]), bool(false), 'Example 4';

is same_row_column([1, 2, 3],
                   [3, 1, 2],
                   [3, 2, 1]), bool(false), 'Example 5';

# There was no example with compliant columns but noncompliant rows.
is same_row_column([1, 1, 1],
                   [2, 2, 2],
                   [3, 3, 3]), bool(false), 'Break rows';
