#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub word_squares(@words) {
    return word_squares_rec([], [], @words)
}

sub word_squares_rec($grid, $used, @words) {
    for my $wi (0 .. $#words) {
        my $word = $words[$wi];
        push @$grid, [split //, $word];

        my $ok = 1;
        for my $i (0 .. $#{ $grid->[0] }) {
            my $prefix = join "", map $grid->[$_][$i] // "", 0 .. $#$grid;
            undef $ok if ! grep 0 == index($_, $prefix), @$used, @words;
        }
        if ($ok) {
            return @$used, $words[$wi] if @$grid == @{ $grid->[0] };
            return word_squares_rec($grid,
                                    [@$used, $words[$wi]],
                                    @words[ grep $_ != $wi, 0 .. $#words ]);
        }
        pop @$grid;
    }
    return
}

use Test2::V0;
plan(5 + 2);

is [word_squares('MA', 'AM', 'MY', 'ME')],
    in_set(['MA', 'AM'], ['AM', 'ME'], ['AM', 'MY'], ['AM', 'MA']), 'Example 1';

is [word_squares('SUN', 'USE', 'NET', 'SEE', 'TEN')],
    ['SUN', 'USE', 'NET'],
    'Example 2';

is [word_squares('BOAT', 'TEAL', 'AREA', 'TSAR', 'OGRE')],
    ['BOAT', 'OGRE', 'AREA', 'TEAL'],
    'Example 3';

is [word_squares('CARD', 'AREA', 'REAR', 'DART')],
    ['CARD', 'AREA', 'REAR', 'DART'],
    'Example 4';

is [word_squares('HEART', 'TREND', 'EMBER', 'RESIN', 'ABUSE')],
    ['HEART', 'EMBER', 'ABUSE', 'RESIN', 'TREND'],
    'Example 5';

is [word_squares('BOAT', 'TSAR', 'TEAL', 'AREA', 'OURS', 'OGRE')],
    in_set(['BOAT', 'OGRE', 'AREA', 'TEAL'],
           ['BOAT', 'OURS', 'AREA', 'TSAR']),
    'Two solutions';

is [word_squares('SUN', 'LET', 'FLY', 'WOK', 'MAN', 'PEN')], [], 'No solution';
