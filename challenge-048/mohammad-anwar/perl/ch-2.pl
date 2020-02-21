#!/usr/bin/perl

use strict;
use warnings;
use Date::Tiny;

my $date = Date::Tiny->new(year => 2000, month => 1, day => 1);

while ($date->year <= 2299) {
    my $date_as_str = sprintf("%02d%02d%04d", $date->month, $date->day, $date->year);
    if ($date_as_str eq reverse($date_as_str)) {
        print "$date_as_str is a Palindrome date.\n";
    }
    my $datetime = $date->DateTime->add(days => 1);
    $date = Date::Tiny->new(year => $datetime->year, month => $datetime->month, day => $datetime->day);
}

END {
    my $time = time - $^T;
    my $mm   = $time / 60;
    my $ss   = $time % 60;
    my $hh   = $mm / 60;
    $mm = $mm % 60;

    print sprintf("The program ran for %02d:%02d:%02d.\n", $hh, $mm, $ss);
}
