#!/usr/bin/perl

use v5.40;

use Test::More tests => 3;

use List::Util qw(min max pairs);

sub play_game {
    return min(@_) if @_ == 2;
    my $f = \&max;
    return play_game(
        map {
            $f = $f == \&min ? \&max : \&min;
            $f->($_->[0], $_->[1]);
        } pairs @_
    );
}

is(play_game(2, 1, 4, 5, 6, 3, 0, 2),                         1);
is(play_game(0, 5, 3, 2),                                     0);
is(play_game(9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8), 2);
