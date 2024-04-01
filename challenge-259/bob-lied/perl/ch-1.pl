#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-1.pl Perl Weekly Challenge 259 Task 1 Banking Day Offset
#=============================================================================
# You are given a start date and offset counter. Optionally you also get bank
# holiday date list.  Given a number (of days) and a start date, return the
# number (of days) adjusted to take into account non-banking days. In other
# words: convert a banking day offset to a calendar day offset.
# Non-banking days are: a) Weekends b) Bank holidays
# Example 1
# Input: $start_date = '2018-06-28', $offset = 3, $bank_holidays = ['2018-07-03']
# Output: '2018-07-04'
#   Thursday bumped to Wednesday (3 day offset, with Monday a bank holiday)
# Example 2
# Input: $start_date = '2018-06-28', $offset = 3
# Output: '2018-07-03'
#=============================================================================
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub bdo($startDate, $offset, $holiday = [])
{
    use DateTime::Format::ISO8601;

    my $day = DateTime::Format::ISO8601->parse_datetime($startDate);

    # Convert holday list into a hash for easy lookup
    my %bh = map { $_ => 1 } $holiday->@*;

    while ( $offset > 0 )
    {
        $day->add(days => 1);
        $offset-- if ! ( $day->day_of_week == 6
                      || $day->day_of_week == 7 
                      || $bh{$day->ymd}
                    );
    }
    return $day->ymd;
}

sub runTest
{
    use Test2::V0;

    is( bdo('2018-06-28', 3, ['2018-07-03'] ), '2018-07-04', "Example 1");
    is( bdo('2018-06-28', 3                 ), '2018-07-03', "Example 1");

    done_testing;
}
