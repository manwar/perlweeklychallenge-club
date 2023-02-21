#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 178 Task 2 Business Date
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given $timestamp (date with time) and $duration in hours.
# Write a script to find the time that occurs $duration business hours after
# $timestamp. For the sake of this task, let us assume the working hours is
# 9am to 6pm, Monday to Friday. Please ignore timezone too.
# For example,
# Suppose the given timestamp is 2022-08-01 10:30 and the duration is 4 hours.
# Then the next business date would be 2022-08-01 14:30.
# If the given timestamp is 2022-08-01 17:00 and the duration is 3.5 hours,
# then the next business date would be 2022-08-02 11:30.
#=============================================================================

use v5.36;

use Time::Local;
use Time::Piece;
use Time::Seconds;

my $StartHour = "09:00";
my $EndHour   = "18:00";
my $StartTime = Time::Piece->strptime($StartHour, "%H:%M");
my $EndTime  = Time::Piece->strptime($EndHour, "%H:%M");
my $DayLength = $EndTime - $StartTime;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my ($ts, $duration) = @ARGV;

say businessDate($ts, $duration);

sub businessDate($timestamp, $duration)
{
    my $ts = Time::Piece->strptime($timestamp, "%F %R");

    my $startDOW = $ts->day_of_week;
    if ( $startDOW == 0 ) # Start day is Sunday, jump to Monday
    {
        $ts += ONE_DAY;
        $ts = Time::Piece->strptime($ts->ymd." $StartHour", "%F %R");
    }
    elsif ( $startDOW == 6 ) # Jump from Saturday to Monday morning
    {
        $ts += ONE_DAY * 2;
        $ts = Time::Piece->strptime($ts->ymd." $StartHour", "%F %R");
    }

    my $remainingTime = Time::Seconds->new($duration * ONE_HOUR);

    my $dayStart = Time::Piece->strptime( $ts->ymd." $StartHour", "%F %R");
    my $dayEnd   = Time::Piece->strptime( $ts->ymd." $EndHour",   "%F %R");

    if ( ($ts + $remainingTime) <= $dayEnd )
    {
        # All within the same day, this is easy.
        return ($ts + $remainingTime)->strftime("%F %R");
    }

    my $busDate = $ts;

    # Add weekends for each full week.
    my $workWeeks = int($remainingTime / ($DayLength*5));
    $busDate += ($workWeeks * 7) * ONE_DAY;
    $remainingTime -= $workWeeks * 5 * $DayLength;

    # Add full days.  Account for weekends as we wrap from one day to the
    # next.  day_of_week maps M:F to 1:5, 
    my $days = int($remainingTime / $DayLength);
    my $workDay = $busDate->day_of_week - 1; # 0-4, Monday=0

    # If we wrap around, add two days for the weekend
    if ( ( ($workDay + $days) % 5) < $workDay )
    {
        $busDate += ONE_DAY * 2;
    }
    $busDate += ONE_DAY * $days;

    $remainingTime -= $days * $DayLength;

    # Now we have part of a day left.
    $dayEnd = Time::Piece->strptime( $busDate->ymd." $EndHour", "%F %R");
    if ( ($busDate + $remainingTime) <= $dayEnd )
    {
        return ($busDate + $remainingTime)->strftime("%F %R");
    }

    # Wrap around to the next day.  Handle Friday afternoon.
    $remainingTime -= ($dayEnd - $busDate);
    if ( $busDate->day_of_week == 5 )
    {
        # Jump from Friday afternoon to Monday
        $busDate += ONE_DAY * 3;
    }
    else
    {
        $busDate += ONE_DAY;
    }
    # Back up to the start of the day and add the remaining time.
    $busDate = Time::Piece->strptime($busDate->ymd." $StartHour", "%F %R");
    $busDate += $remainingTime;
    return $busDate->strftime("%F %R");
}

sub runTest
{
    use Test2::V0;

    is( businessDate("2022-08-01 10:30", 4),   "2022-08-01 14:30", "Example 1");
    is( businessDate("2022-08-01 17:00", 3.5), "2022-08-02 11:30", "Example 2");
    is( businessDate("2022-08-01 17:00", 11),  "2022-08-03 10:00", "2 days");
    is( businessDate("2022-08-05 16:00",  3),  "2022-08-08 10:00", "Friday afternoon");
    is( businessDate("2022-08-01 09:00", 45),  "2022-08-08 09:00", "45-hour week");

    done_testing;
}

