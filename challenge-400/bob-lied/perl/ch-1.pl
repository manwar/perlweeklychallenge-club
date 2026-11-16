#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 400 Task 1  Largest Interval
#=============================================================================
# You are given a positive integer.  Write a script that generates a sequence
# of integers from 1 to given positive integer, filtering out any numbers that
# contain repeating digits (e.g., 11, 99, 100, and 101 are excluded) and
# return the biggest jump.
# Example 1 Input: $int = 20
#           Output: 2
#   Biggest jump between 10 and 12.
# Example 2 Input: $int = 110
#           Output: 4
#   Biggest jump between 98 and 102.
# Example 3 Input: $int = 500
#           Output: 11
#   Biggest jump between:
#   109 to 120 => 11 |  219 to 230 => 11 | 329 to 340 => 11 | 439 to 450 => 11
# Example 4 Input: $int = 2026
#           Output: 105
#   Biggest jump between 1098 and 1203.
# Example 5 Input: $int = 10000
#           Output: 105
#   The largest gap is 105, between 1098 and 1203. And between 8796 and 8901.
#=============================================================================

use v5.44;


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

say task($_) for @ARGV;

#=============================================================================

sub task($int)
{
    use List::Util qw/max/;
    use List::MoreUtils qw/slide duplicates/;
    return max
            slide { $b - $a }
                grep { duplicates(split(//, $_)) == 0 }
                    1 .. $int;
}


sub runTest
{
    use Test2::V1 -ipP;

    is( task(   20),   2, "Example 1");
    is( task(  110),   4, "Example 2");
    is( task(  500),  11, "Example 3");
    is( task( 2026), 105, "Example 4");
    is( task(10000), 105, "Example 5");

    done_testing;
}
