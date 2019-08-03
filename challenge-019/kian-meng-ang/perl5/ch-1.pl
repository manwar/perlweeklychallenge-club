#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say);

use Date::Calc qw(Days_in_Month Day_of_Week);

# Naive and brute force approach, just exploring.
foreach my $y (1900..2019) {
    foreach my $m (1..12) {
        my %dow_count = ();
        foreach my $d (1..Days_in_Month($y, $m)) {
            $dow_count{Day_of_Week($y, $m, $d)}++;
        }

        if ($dow_count{5} == 5 && $dow_count{6} == 5 && $dow_count{7} == 5) {
            say sprintf '%s-%02d', $y, $m;
        }
    }
}

1;
