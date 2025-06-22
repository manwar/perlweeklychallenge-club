#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 326 Task 1  Day of Year
#=============================================================================
# You are given a date in the format YYYY-MM-DD.  Write a script to find day
# number of the year that the given date represent.
# Example 1 Input: $date = '2025-02-02' Output: 33
#   The 2nd Feb, 2025 is the 33rd day of the year.
# Example 2 Input: $date = '2025-04-10' Output: 100
# Example 3 Input: $date = '2025-09-07' Output: 250
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

say yearDay($_) for @ARGV;

#=============================================================================
sub yearDay($date)
{
    use Time::Piece;
    return Time::Piece->strptime($date, "%Y-%m-%d")->day_of_year() + 1;
}

sub runTest
{
    use Test2::V0;

    is( yearDay("2025-02-02"),  33, "Example 1");
    is( yearDay("2025-04-10"), 100, "Example 2");
    is( yearDay("2025-09-07"), 250, "Example 3");

    done_testing;
}
