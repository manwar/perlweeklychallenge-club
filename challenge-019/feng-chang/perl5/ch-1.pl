#!/bin/env perl

use Modern::Perl;
use Date::Manip;

for my $year (1900 .. 2019) {
    for my $month (1,3,5,7,8,10,12) {
        my $d = ParseDate("$year/$month/1");
        if (UnixDate($d, '%w') == 5) {
            say sprintf('%d-%02d has 5 weekends', $year, $month);
        }
    }
}
