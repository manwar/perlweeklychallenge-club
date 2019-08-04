#!/usr/bin/env perl6
#
# Script to display months from the year 1900 to 2019 where you find 5 weekends,
# i.e. 5 Fridays, 5 Saturdays and 5 Sundays.
#
# Months have a maximum of 31 days; for 5 weekends to fit in a 31-day month, the (31-4*7=)
# 3 days at the extremities of the month should also be a weekend, i.e. the first day of
# a 31-month day should be a Friday.

for 1900..2019 -> $year {
    for 1..12 -> $month {
        my $d = Date.new($year,$month,1);
        say "$d.year()/$d.month()" if $d.day-of-week == 5 && $d.days-in-month == 31;
    }
}