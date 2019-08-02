#!/usr/bin/env perl

# Write a script to display months from the year 1900 to 2019 where you find 5
# weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

use 5.026;
use strict;
use warnings;
use DateTime;

=pod

First, let's realize that in order to have 5 Fridays, Saturdays, and Sundays a
month must have 31 days B<and> it's first day must be a Friday. If its first day
is a Friday, the fifth Friday is day 29 and its fifth Sunday is day 31. There is
no other choice.

So, we need only find which months have 31 days and start in a Friday.
=cut

my @months_with_31_days = (1, 3, 5, 7, 8, 10, 12);

for my $year (1900 .. 2019) {
    for my $month (@months_with_31_days) {
        my $first_day_of_month = DateTime->new(
            year  => $year,
            month => $month,
            day   => 1,
        );
        if ($first_day_of_month->day_of_week() == 5) {
            printf "%04d-%02d\n", $year, $month;
        }
    }
}
