#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 347 Task 1  Format Date
#=============================================================================
# You are given a date in the form: 10th Nov 2025.  Write a script to format
# the given date in the form: 2025-11-10 using the set below.
# @DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")
# @MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")
# @YEARS  = (1900..2100)
# Example 1 Input: $str = "1st Jan 2025"
#           Output: "2025-01-01"
# Example 2 Input: $str = "22nd Feb 2025"
#           Output: "2025-02-22"
# Example 3 Input: $str = "15th Apr 2025"
#           Output: "2025-04-15"
# Example 4 Input: $str = "23rd Oct 2025"
#           Output: "2025-10-23"
# Example 5 Input: $str = "31st Dec 2025"
#           Output: "2025-12-31"
# 
#=============================================================================
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say fmtDate($_) for @ARGV;

#=============================================================================
sub fmtDate($str)
{
    state %MONTH = ( Jan => "01", Feb => "02", Mar => "03", Apr => "04",
                     May => "05", Jun => "06", Jul => "07", Aug => "08",
                     Sep => "09", Oct => "10", Nov => "11", Dec => "12");

    my ($dd, $mmm, $yyyy) = $str =~ m/(\d+)(?:st|nd|rd|th) (\w+) (\d{4})/;

    return sprintf("%4d-%02d-%02d", $yyyy, $MONTH{$mmm}, $dd);
}

sub runTest
{
    use Test2::V0;

    is( fmtDate( "1st Jan 2025"), "2025-01-01", "Example 1");
    is( fmtDate("22nd Feb 2025"), "2025-02-22", "Example 2");
    is( fmtDate("15th Apr 2025"), "2025-04-15", "Example 3");
    is( fmtDate("23rd Oct 2025"), "2025-10-23", "Example 4");
    is( fmtDate("31st Dec 2025"), "2025-12-31", "Example 5");

    done_testing;
}
