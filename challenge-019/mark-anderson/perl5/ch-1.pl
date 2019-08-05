#!/usr/bin/env perl

use Modern::Perl '2018';
use DateTime;

for my $year (1900 .. 2019) {
    for my $month (1 .. 12) {
        my $dt = DateTime->last_day_of_month(
                    year  => $year,
                    month => $month);

        while($dt->day_name ne 'Sunday') {
            $dt->subtract(days => 1);
        }

        if($dt->weekday_of_month == 5                     and
          $dt->subtract(days => 1)->weekday_of_month == 5 and
          $dt->subtract(days => 1)->weekday_of_month == 5) {
              say "$month/$year";
        }
    }
}

