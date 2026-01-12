#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my @W = ([2, 7], [3, 6], [4, 5], [1, \2], [\0, \1]);

sub who_wins($results) {
    my @week1;
    my $winner = sub($pos) {
        my $r = $W[$pos][ 'A' eq substr $results, $pos, 1 ];
        return ref $r ? $week1[$$r] : $r
    };
    @week1 = sort map $winner->($_), 0, 1, 2;
    my @week2 = sort map $winner->($_), 3, 4;
    @week2 = reverse @week2 if 'A' eq substr $results, 5, 1;
    return "Team $week2[0] defeated Team $week2[1]"
}

use Test::More tests => 5;

is who_wins('HAHAHH'), 'Team 2 defeated Team 6', 'Example 1';
is who_wins('HHHHHH'), 'Team 1 defeated Team 2', 'Example 2';
is who_wins('HHHAHA'), 'Team 4 defeated Team 2', 'Example 3';
is who_wins('HAHAAH'), 'Team 4 defeated Team 6', 'Example 4';
is who_wins('HAAHAA'), 'Team 5 defeated Team 1', 'Example 5';
