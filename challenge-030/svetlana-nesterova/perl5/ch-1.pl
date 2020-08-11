#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use DateTime;
use DateTime::Format::HTTP;

use constant SUNDAY => 7;


=Write a script to list dates for Sunday Christmas between 2019 and 2100.
 For example, 25 Dec 2022 is Sunday.
=cut


sub PrintSundayChristmases() {
    for my $year (2019 .. 2100) {
        my $christmas = DateTime->new(year => $year, month => 12, day => 25);
        if ($christmas->day_of_week == SUNDAY) {
            print DateTime::Format::HTTP->format_datetime($christmas), "\n";
        }
    }
}

PrintSundayChristmases();
