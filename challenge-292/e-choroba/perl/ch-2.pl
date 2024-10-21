#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Memoize qw{ memoize };
memoize('zuma_game');

sub zuma_game($board, $hand) {
    return 0  if "" eq $board;
    return -1 if "" eq $hand;

    my %uniq;
    @uniq{ split //, $hand } = ();
    my $result = -1;
    for my $ball (keys %uniq) {
        for my $pos (0 .. length $board) {
            my $next_board = $board;
            substr $next_board, $pos, 0, $ball;

            # Remove groups of 3+ balls.
            $next_board =~ s/(.)\1{2,}//g while $next_board =~ /(.)\1{2,}/;

            my $steps = zuma_game($next_board, $hand =~ s/$ball//r);
            if (-1 != $steps) {
                $result = 1 + $steps if -1 == $result
                                     || $steps < $result;
            }
        }
    }
    return $result
}

use Test::More tests => 3 + 3;

is zuma_game('WRRBBW', 'RB'), -1, 'Example 1';
is zuma_game('WWRRBBWW', 'WRBRW'), 2, 'Example 2';
is zuma_game('G', 'GGGGG'), 2, 'Example 3';

is zuma_game('RBBGBRR', 'GG'), 2, 'RBBGBRR, GG, 2';
is zuma_game('RGBBGYYGR', 'RGBY'), 3, 'RGBBGYYGR, RGBY, 3';
is zuma_game('CMMCYYCKKC', 'CMYK'), 3, 'CMYK';
