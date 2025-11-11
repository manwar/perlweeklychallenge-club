#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-347/#TASK1
#
# Task 1: Format Date
# ===================
#
# You are given a date in the form: 10th Nov 2025.
#
# Write a script to format the given date in the form: 2025-11-10 using the set below.
#
# @DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")
# @MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")
# @YEARS  = (1900..2100)
#
#
## Example 1
##
## Input: $str = "1st Jan 2025"
## Output: "2025-01-01"
#
#
## Example 2
##
## Input: $str = "22nd Feb 2025"
## Output: "2025-02-22"
#
#
## Example 3
##
## Input: $str = "15th Apr 2025"
## Output: "2025-04-15"
#
#
## Example 4
##
## Input: $str = "23rd Oct 2025"
## Output: "2025-10-23"
#
#
## Example 5
##
## Input: $str = "31st Dec 2025"
## Output: "2025-12-31"
#
############################################################
##
## discussion
##
############################################################
#
# Since we can pick the year as-is, we just need to translate
# the day and month. So we get the index of the saved strings
# for both in an array, add one to get the day/month as a number,
# and add a leading 0 if necessary.

use v5.36;

my @DAYS   = get_days();
my @MONTHS = get_months();
my @YEARS  = (1900..2100);

format_date("1st Jan 2025");
format_date("22nd Feb 2025");
format_date("15th Apr 2025");
format_date("23rd Oct 2025");
format_date("31st Dec 2025");

sub format_date($str) {
    say "Input: '$str'";
    my ($d, $m, $y) = split /\s+/, $str;
    my $output = "${y}-" . indexed($m, @MONTHS) . "-" . indexed($d, @DAYS);
    say "Output: '$output'";
}

sub indexed($str, @array) {
    foreach my $i (0..$#array) {
        if($str eq $array[$i]) {
            return sprintf("%02d", $i+1);
        }
    }
    return sprintf("%02d", 0); # fallback
}

sub get_days() {
    my @DAYS   = ("1st", "2nd", "3rd");
    foreach(4..20) {
        push @DAYS, "${_}th";
    }
    push @DAYS, "21st";
    push @DAYS, "22nd";
    push @DAYS, "23rd";
    foreach(24..30) {
        push @DAYS, "${_}th";
    }
    push @DAYS, "31st";
    return @DAYS;
}

sub get_months() {
    return ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov",  "Dec");
}

