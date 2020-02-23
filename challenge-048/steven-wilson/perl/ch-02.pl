#!/usr/bin/env perl
# Steven Wilson
# Challenge 048 Task #2
# 22 Feb 2020

# Palindrome Dates

# Write a script to print all Palindrome Dates between 2000 and 2999.
# The format of date is mmddyyyy. For example, the first one was on
# October 2, 2001 as it is represented as 10022001.

use strict;
use warnings;
use feature qw/ say /;
use DateTime;

my $year = 2000;

while ( $year < 3000 ) {
    eval {
        my $dt = DateTime->new(
            year  => $year,
            month => substr( $year, -1, 1 ) . ( substr $year, -2, 1 ),
            day   => substr( $year, -3, 1 ) . ( substr $year, -4, 1 ),
        );
        my $reay = reverse $year;
        say "$reay$year";
    };
    $year++;
}

# Output:
# 10022001
# 01022010
# 11022011
# 02022020
# 12022021
# 03022030
# 04022040
# 05022050
# 06022060
# 07022070
# 08022080
# 09022090
# 10122101
# 01122110
# 11122111
# 02122120
# 12122121
# 03122130
# 04122140
# 05122150
# 06122160
# 07122170
# 08122180
# 09122190
# 10222201
# 01222210
# 11222211
# 02222220
# 12222221
# 03222230
# 04222240
# 05222250
# 06222260
# 07222270
# 08222280
# 09222290
