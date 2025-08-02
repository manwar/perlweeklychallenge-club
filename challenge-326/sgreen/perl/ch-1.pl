#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Date::Calc 'Day_of_Year';

sub main ($date) {
    if ($date !~ /^[0-9]{4}-[0-9][0-9]?-[0-9][0-9]?$/) {
        die "Usage: $0 YYYY-MM-DD\n";
    }

    say Day_of_Year(split /-/, $date);
}

main($ARGV[0]);