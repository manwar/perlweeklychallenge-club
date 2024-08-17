#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub knights_move($start, $end) {
    return 0 if $start eq $end;

    tr/a-h/1-8/ for $start, $end;
    my %agenda = ($start => undef);
    my %visited;
    my $tally = 1;

  SEARCH:
    while (1) {
        my %next;
        for my $coord (keys %agenda) {
            my ($x, $y) = split //, $coord;
            for my $jump ([-2, -1], [-1, -2], [1, -2], [2, -1],
                          [2, 1], [1, 2], [-1, 2], [-2, 1]
            ) {
                my ($x2, $y2) = ($x + $jump->[0], $y + $jump->[1]);
                next if $x2 < 1 || $y2 < 1 || $x2 > 8 || $y2 > 8;

                last SEARCH if "$x2$y2" eq $end;

                undef $next{"$x2$y2"};
            }
        }
        %agenda = %next;
    } continue {
        ++$tally;
    }
    return $tally
}

use Test::More tests => 2 + 2;

is knights_move('g2', 'a8'), 4, 'Example 1';
is knights_move('g2', 'h2'), 3, 'Example 2';

is knights_move('a1', 'a1'), 0, 'Zero';
is knights_move('a1', 'h8'), 6, 'Far';
