#!/usr/bin/env perl
use strict;
use warnings;

use Time::Piece;

my $d  = Time::Piece->strptime ('20191225', '%Y%m%d');;
my $dow = 1;
while ($d->year < 2101) {
    if ($d->wday == $dow) {
        printf "%s is %s\n", $d->strftime ('%d %b %Y'), $d->fullday;
        $d = $d->add_years (5);
    } else {
        $d = $d->add_years (1);
    }
}

