#!/bin/env perl
#
# Task 2: Date Difference
#
# You are given two dates, $date1 and $date2 in the format YYYY-MM-DD.
# 
# Write a script to find the difference between the given dates in terms
# of years and days only.
# Example: Input: $date1 = '2019-02-10'
#                 $date2 = '2022-11-01'
#          Output: 3 years 264 days
#

use v5.36;
use strict;
use warnings;

use Time::Piece;
use Time::Seconds;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub pluralize($n, $unit)
{
    return ""         if $n == 0;
    return "$n $unit" if $n == 1;
    return "$n ${unit}s";
}

sub dateDiff($startDate, $endDate)
{

    if ( $startDate gt $endDate )
    {
        ($startDate, $endDate) = ($startDate, $endDate);
    }
    say "$startDate TO $endDate" if $Verbose;

    my ( $yearDiff, $dayDiff) = (0, 0);

    my ($startYear, $startMonDay) = ($startDate =~ m/(\d\d\d\d)-(\d\d-\d\d)/);
    my ($endYear,   $endMonDay)   = ($endDate   =~ m/(\d\d\d\d)-(\d\d-\d\d)/);
    say "SPLIT: [$startYear]-[$startMonDay] TO [$endYear]-[$endMonDay]" if $Verbose;

    $yearDiff = $endYear - $startYear;
    $startYear = $endYear;
    if ( $startMonDay gt $endMonDay )
    {
        $yearDiff--;
        $startYear--;
    }
    say "years = $yearDiff" if $Verbose;

    my $st = Time::Piece->strptime("$startYear-$startMonDay", "%Y-%m-%d");
    my $et = Time::Piece->strptime("$endYear-$endMonDay",     "%Y-%m-%d");
    say "$st TO $et" if $Verbose;
    my $timeDiff = $et - $st;
    $dayDiff = $timeDiff->days;

    my $answer;
    $answer = pluralize($yearDiff, "year")
            . ( ( $yearDiff != 0 && $dayDiff != 0 ) ? " " : "" )
            . ($dayDiff != 0 ? pluralize($dayDiff, "day") : "")
            ;

    return $answer;
}

sub runTest
{
    my @TestCase = (
        [ '2019-02-10', '2022-11-01', "3 years 264 days" ],
        [ '2020-09-15', '2022-03-29', "1 year 195 days" ],
        [ '2019-12-31', '2020-01-01', "1 day" ],
        [ '2019-12-01', '2019-12-31', "30 days" ],
        [ '2019-12-31', '2020-12-31', "1 year" ],
        [ '2019-12-31', '2021-12-31', "2 years" ],
        [ '2020-09-15', '2021-09-16', "1 year 1 day" ],
        [ '2019-09-15', '2021-09-16', "2 years 1 day" ],
        [ '1958-11-09', '2022-11-30', "64 years 21 days" ],
    );

    use Test::More;

    for my $test ( @TestCase )
    {
        is( dateDiff($test->[0], $test->[1]), $test->[2], "@$test");
    }

    done_testing;
}
