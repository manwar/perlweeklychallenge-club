#!/usr/bin/perl
# Test: ./ch-1.pl 2230120
use strict;
use warnings;
use feature qw /say/;
use Date::Manip;

say parse_date($ARGV[0]);

sub parse_date {
    my $date = shift;

    # Regex to test date format
    return "Invalid date format"
        unless $date && $date =~ /
            ^                     # start string
            ([12])                # 1 or 2
            (\d\d)                # year 00-99
            (0[1-9]|1[0-2])       # month 1-12
            (0[1-9]|[12]\d|3[01]) # day 1-31
            $                     # end string
        /x;

    # The date string
    my $date_string =
        ( ($1 == 1) ? '20' . $2  : '19' . $2 )
        . '-' . $3 . '-' . $4;

    # Make sure the date is valid
    # even if it passed the format check
    # using Date::Manip
    return "Invalid date"
        unless (ParseDate($date_string));

    return $date_string;
}
