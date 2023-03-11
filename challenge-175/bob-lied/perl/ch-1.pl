#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 175 Task 1 Last Sunday
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Write a script to list Last Sunday of every month in the given year.
# For example, for year 2022, we should get the following:
# 2022-01-30 2022-02-27 2022-03-27 2022-04-24
# 2022-05-29 2022-06-26 2022-07-31 2022-08-28
# 2022-09-25 2022-10-30 2022-11-27 2022-12-25
####
# This is a task for reading the documentation of the DateTime module to
# find the functions we need.
#=============================================================================

use v5.36;

use DateTime;

use Getopt::Long;
my $DoTest  = 0;

GetOptions("test" => \$DoTest);
exit(!runTest()) if $DoTest;

# Takes one argument, a year.
say join("\n", lastSunday($ARGV[0])->@*);

sub lastSunday($year)
{
    my @sundayList;
    for my $month ( 1 .. 12 )
    {
        # Start at the last day of the month and back up until we
        # find a Sunday.
        my $d = DateTime->last_day_of_month( year => $year, month => $month);
        while ( $d->day_of_week != 7 )
        {
            $d->subtract( days => 1 );
        }
        push @sundayList, $d->ymd();
    }
    return \@sundayList;
}

sub runTest
{
    use Test2::V0;

    is( lastSunday(2022), 
                    [ qw( 2022-01-30 2022-02-27 2022-03-27 2022-04-24
                          2022-05-29 2022-06-26 2022-07-31 2022-08-28
                          2022-09-25 2022-10-30 2022-11-27 2022-12-25 ) ],
        , "Year 2022");

    is( lastSunday(1958), 
                    [ qw( 1958-01-26 1958-02-23 1958-03-30 1958-04-27
                          1958-05-25 1958-06-29 1958-07-27 1958-08-31
                          1958-09-28 1958-10-26 1958-11-30 1958-12-28 ) ],
        , "Year 1958");

    done_testing;
}
