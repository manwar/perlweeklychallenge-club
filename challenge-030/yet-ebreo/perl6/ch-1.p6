#!/usr/bin/env perl
# Write a script to list dates for Sunday 
# Christmas between 2019 and 2100. 
# For example, 25 Dec 2022 is Sunday.

for 2019..2100 -> $year {
    my $date = Date.new($year, 12, 25);
    if ($date.day-of-week == 7) {
        say "12/25/$year"
    }
}