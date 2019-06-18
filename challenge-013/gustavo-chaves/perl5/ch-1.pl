#!/usr/bin/env perl

# Write a script to print the date of last Friday of every month of a given
# year. For example, if the given year is 2019 then it should print the
# following:
# 2019/01/25
# 2019/02/22
# 2019/03/29
# 2019/04/26
# 2019/05/31
# 2019/06/28
# 2019/07/26
# 2019/08/30
# 2019/09/27
# 2019/10/25
# 2019/11/29
# 2019/12/27

use 5.026;
use strict;
use autodie;
use warnings;
use DateTime;

my $year = shift or die "Usage: $0 YEAR\n";

for my $month (1 .. 12) {
    my $date = DateTime->last_day_of_month(
        year => $year,
        month => $month,
        time_zone => '+0000',
    );
    printf "%4d/%02d/%02d\n", $year, $month, $date->day() - ($date->day_of_week()+2)%7;
}
