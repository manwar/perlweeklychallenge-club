#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 332 Task 1  Binary Date
#=============================================================================
# You are given a date in the format YYYY-MM-DD.
# Write a script to convert it into binary date.
# Example 1 Input: $date = "2025-07-26"
#           Output: "11111101001-111-11010"
# Example 2 Input: $date = "2000-02-02"
#           Output: "11111010000-10-10"
# Example 3 Input: $date = "2024-12-31"
#           Output: "11111101000-1100-11111"
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest = 0;

GetOptions("test" => \$DoTest);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

say binaryDate($_) for @ARGV;

#=============================================================================
sub binaryDate($date)
{
    return sprintf("%b-%b-%b", split(/-/, $date));
}

sub runTest
{
    use Test2::V0;

    is( binaryDate("2025-07-26"), "11111101001-111-11010", "Example 1");
    is( binaryDate("2000-02-02"), "11111010000-10-10", "Example 2");
    is( binaryDate("2024-12-31"), "11111101000-1100-11111", "Example 3");

    done_testing;
}
