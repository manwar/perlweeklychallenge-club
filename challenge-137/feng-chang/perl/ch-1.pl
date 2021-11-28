#!/bin/env perl

use Date::Manip;

my @years = grep { UnixDate("$_-12-31", '%W') == 53 } 1900..2100;

my $first = 1;
while (@years) {
    $first ? $first = 0 : print ",\n";
    print join ', ', splice @years, 0, 5;
}
print "\n";
