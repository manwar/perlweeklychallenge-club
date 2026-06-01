#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub chessboard_squares($c1, $c2) {
    my @p = map { (ord($_) + ord substr $_, 1) % 2 } $c1, $c2;
    return $p[0] == $p[1]
}

use Test2::V0;
plan(5);

use if ($] >= 5.4), builtin  => qw( true false );
use if ($] < 5.4),  constant => {true => !! 1, false => !! 0};

is chessboard_squares('a7', 'f4'), bool(true), 'Example 1';
is chessboard_squares('c1', 'e8'), bool(false), 'Example 2';
is chessboard_squares('b5', 'h2'), bool(false), 'Example 3';
is chessboard_squares('f3', 'h1'), bool(true), 'Example 4';
is chessboard_squares('a1', 'g8'), bool(false), 'Example 5';
