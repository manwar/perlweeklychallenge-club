#!/usr/bin/perl -s

use v5.16;
use warnings;
use DateTime;

# Maybe I'm missing something: The year's last day's week number is the
# year's week count.
say join ' ', grep DateTime->new(year => $_, month => 12, day => 31,
    time_zone => 'floating')->week_number == 53, 1900 .. 2100;

