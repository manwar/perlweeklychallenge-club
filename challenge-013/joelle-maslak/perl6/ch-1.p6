#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

sub MAIN(UInt:D $year) {
    my $days = get-all-days($year);
    say $days.grep( { last-friday($^dt) } ).join("\n");
}

sub last-friday(Date $dt -->Bool:D) {
    return False if $dt.day-of-week ≠ 5;
    return False if $dt.later(:7days).month == $dt.month;
    return True;
}

sub get-all-days(UInt:D $year) {
    return gather {
        state $dt = Date.new($year, 1, 1);
        while $dt.year == $year {
            take $dt;
            $dt = $dt.succ;
        }
    }
}


