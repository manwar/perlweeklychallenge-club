#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Time::Local;

say "Years during which Christmas falls on a Sunday:";
for my $year (119..200) {
    my $date = timegm(0, 0, 0, 25, 11, $year);
    say $year + 1900 if (gmtime $date)[6] == 0;
}
