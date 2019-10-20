#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

use List::Util qw(min);
use POSIX qw(ceil);

use constant SUM => 12;
use constant MIN_FIRST => ceil(SUM / 3);
use constant MAX_FIRST => SUM - 2;

foreach my $first (MIN_FIRST .. MAX_FIRST) {
    my $min_second = ceil((SUM -$first) / 2);
    my $max_second = min($first, SUM - $first - 1);
    foreach my $second ($min_second .. $max_second) {
        my $third = SUM - $first - $second;
        say "$first, $second, $third"
    }
}

