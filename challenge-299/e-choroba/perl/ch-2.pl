#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub word_search($chars, $str) {
    return 1 if "" eq $str;

    for my $y (0 .. $#$chars) {
        for my $x (0 .. $#{ $chars->[$y] }) {
            return 1 if _word_search($x, $y, $chars, $str, {});
        }
    }
    return
}

{   my @DIRS = ([0, 1], [1, 0], [0, -1], [-1, 0]);
    sub _word_search($x, $y, $chars, $str, $visited) {
        my $first_char = substr $str, 0, 1, "";

        return if $chars->[$y][$x] ne $first_char;
        return 1 if "" eq $str;

        undef $visited->{"$x:$y"};
        for my $dir (@DIRS) {
            my $nx = $x + $dir->[0];
            my $ny = $y + $dir->[1];
            next if $nx < 0 || $ny < 0
                 || $ny > $#$chars || $nx > $#{ $chars->[0] }
                 || exists $visited->{"$nx:$ny"};

            return 1 if _word_search($nx, $ny, $chars, $str,
                                     {%$visited, "$nx:$ny" => undef});
        }
        return
    }
}

use Test2::V0;
plan(3 + 2);

use constant {true => bool(1), false => bool(0)};

is word_search([['A', 'B', 'D', 'E'],
                ['C', 'B', 'C', 'A'],
                ['B', 'A', 'A', 'D'],
                ['D', 'B', 'B', 'C']],
               'BDCA'),
    true, 'Example 1';

is word_search([['A', 'A', 'B', 'B'],
                ['C', 'C', 'B', 'A'],
                ['C', 'A', 'A', 'A'],
                ['B', 'B', 'B', 'B']],
               'ABAC'),
    false, 'Example 2';

is word_search([['B', 'A', 'B', 'A'],
                ['C', 'C', 'C', 'C'],
                ['A', 'B', 'A', 'B'],
                ['B', 'B', 'A', 'A']],
               'CCCAA'),
    true, 'Example 3';

is word_search([[qw[ A B C ]],
                [qw[ A B C ]]],
               ""),
    true, 'Empty string';

is word_search([[qw[ L I H ]],
                [qw[ K J G ]],
                [qw[ D E F ]],
                [qw[ C B A ]]],
               'ABCDEFGHIJKL'),
    true, 'All letters';
