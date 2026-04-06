#!/usr/bin/perl
use 5.038;
use warnings;
use Time::Piece;
use Time::Seconds;

my ($start1, $end1, $start2, $end2) = 
    map { Time::Piece->strptime("01 02 $_", "%m %d %H:%M") } @ARGV[0 .. 3];

if ($start1 > $end1) {
    $start1 -= ONE_DAY;
}

if ($start2 > $end2) {
    $start2 -= ONE_DAY;
}

say 0+($start1 < $end2 && $start2 < $end1) ? 'true' : 'false';