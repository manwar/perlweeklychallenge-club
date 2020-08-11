#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

my $week_day = 2;
for (2019 .. 2099) {
    $week_day = ($week_day + ($_ % 4 == 0 ? 2 : 1)) % 7;
    say $_ if $week_day == 0;
}
