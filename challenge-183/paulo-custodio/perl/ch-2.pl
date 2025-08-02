#!/usr/bin/env perl

# Challenge 183
#
# Task 2: Date Difference
# Submitted by: Mohammad S Anwar
#
# You are given two dates, $date1 and $date2 in the format YYYY-MM-DD.
#
# Write a script to find the difference between the given dates in terms on years
# and days only.
# Example 1
#
# Input: $date1 = '2019-02-10'
#        $date2 = '2022-11-01'
# Output: 3 years 264 days
#
# Example 2
#
# Input: $date1 = '2020-09-15'
#        $date2 = '2022-03-29'
# Output: 1 year 195 days
#
# Example 3
#
# Input: $date1 = '2019-12-31'
#        $date2 = '2020-01-01'
# Output: 1 day
#
# Example 4
#
# Input: $date1 = '2019-12-01'
#        $date2 = '2019-12-31'
# Output: 30 days
#
# Example 5
#
# Input: $date1 = '2019-12-31'
#        $date2 = '2020-12-31'
# Output: 1 year
#
# Example 6
#
# Input: $date1 = '2019-12-31'
#        $date2 = '2021-12-31'
# Output: 2 years
#
# Example 7
#
# Input: $date1 = '2020-09-15'
#        $date2 = '2021-09-16'
# Output: 1 year 1 day
#
# Example 8
#
# Input: $date1 = '2019-09-15'
#        $date2 = '2021-09-16'
# Output: 2 years 1 day

use Modern::Perl;
use DateTime;
use DateTime::Format::Strptime;

sub date_diff {
    my($dt1, $dt2) = @_;
    my $diff = $dt2->subtract_datetime($dt1);
    my $years = $diff->in_units('years');
    my $result = $years==0 ? "" : $years==1 ? "1 year " : "$years years ";
    $dt1->add_duration(DateTime::Duration->new(years=>$years));
    my $days = $dt2->delta_days($dt1)->delta_days();
    $result .= $days==0 ? "" : $days==1 ? "1 day" : "$days days";
    return $result;
}

@ARGV==2 or die "usage: ch-2.pl yyyy-mm-dd yyyy-mm-dd\n";
my $strp = DateTime::Format::Strptime->new(pattern=>'%Y-%m-%d');
my @dt = map {$strp->parse_datetime($_)} @ARGV;
say date_diff(@dt);
