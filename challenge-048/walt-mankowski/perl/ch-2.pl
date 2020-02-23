#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.30);
use experimental qw(signatures);
use DateTime;

# TASK #2
# Palindrome Dates

# Write a script to print all Palindrome Dates between 2000 and
# 2999. The format of date is mmddyyyy. For example, the first one was
# on October 2, 2001 as it is represented as 10022001.

for my $year (2000..2999) {
    my $month = reverse(substr($year, 2, 2));
    if ($month >= 1 && $month <= 12) {
        my $dt = DateTime->new(year => $year, month => $month);
        for my $day (1..$dt->month_length()) {
            my $date = sprintf("%02d%02d%d", $month, $day, $year);
            say $date if $date eq reverse($date);
        }
    }
}
