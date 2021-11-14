#!/usr/bin/env perl

use strict;
use warnings;
use 5.30.0;

use Date::Calc qw (leap_year Day_of_Week);

# Author: Robert DiCicco
# Date: 01-NOV-2021
# Challenge 137

# ISO-8601
# An ISO calendar year is long if and only if the corresponding Gregorian
# year begins on a Thursday when it is a common year or begins either on a
# Wednesday or a Thursday when it is a leap year.

# An ISO calendar year is long if and only if the corresponding Gregorian
# year either begins or ends (or both) on a Thursday.

my @years = (1900..2100);
my @output_arr = ();

foreach (@years){
    my $leap_flag = 0;
    if (leap_year($_)) {
        $leap_flag = 1;
    }

    my $sdow = Day_of_Week($_, 1, 1);  # Jan. 1st  dow for selected year
    my $ldow = Day_of_Week($_,12,31);  # Dec. 31st dow for selected year

    if ($leap_flag){    # if this ia a leap year
        if (($sdow == 3) || ($ldow == 5)){  # and the start dow is Wed., or last dow is Fri.
            push(@output_arr, $_);  # then add to the output array
        }
    }
    else { # not a leap year
        if (($sdow == 4) || ($ldow == 4)){  # and the start dow is Thur., or last dow is Thur.
            push(@output_arr, $_);  # then add to the output array
        }
    }
}

print("\n");
print("Find all the years between 1900 and 2100 which is a Long Year.\n");
print("Output:\n@output_arr\n");
