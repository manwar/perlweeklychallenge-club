#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Time::Piece;

sub day_of_the_year($date) {
    my $tp = 'Time::Piece'->strptime($date, '%Y-%m-%d');
    return 1 + $tp->yday
}

use Test::More tests => 3 + 1;

is day_of_the_year('2025-02-02'), 33, 'Example 1';
is day_of_the_year('2025-04-10'), 100, 'Example 2';
is day_of_the_year('2025-09-07'), 250, 'Example 3';

is day_of_the_year('2024-09-07'), 251, 'Leap year';
