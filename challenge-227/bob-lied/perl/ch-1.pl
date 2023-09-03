#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Task 1 Friday 13th 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a year number in the range 1753 to 9999.
# Write a script to find out how many dates in the year are Friday 13th,
# assume that the current Gregorian calendar applies.
# Example Input: $year = 2023 Output: 2
# Since there are only 2 Friday 13th in the given year 2023
# i.e. 13th Jan and 13th Oct.
#=============================================================================

use v5.36;

use DateTime;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub friday13($year)
{
    return scalar grep { DateTime->new(year=>$year, month=>$_, day=>13)->day_of_week == 5 } 1 .. 12;
}

sub runTest
{
    use Test2::V0;

    is( friday13(2020), 2, "For 2020");
    is( friday13(2021), 1, "For 2021");
    is( friday13(2022), 1, "For 2022");
    is( friday13(2023), 2, "Example");
    is( friday13(2024), 2, "For 2024");
    is( friday13(2025), 1, "For 2025");
    is( friday13(2026), 3, "For 2026");
    is( friday13(2027), 1, "For 2027");

    done_testing;
}
