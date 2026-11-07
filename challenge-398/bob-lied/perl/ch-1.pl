#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 398 Task 1  Divisible Average
#=============================================================================
# You are given an array of positive integers.  Write a script to return
# the closest integer to the mean value of all even integers that are
# divisible by 3. If none is divisible, return 0.
# Example 1 Input: @arr = (18, 5, 7, 11)
#           Output: 18
# Example 2 Input: @arr = (6, 12, 18, 24, 30, 40)
#           Output: 18
# Example 3 Input: @arr = (3, 9, 15, 21, 27)
#           Output: 0
# Example 4 Input: @arr = (6, 12, 14, 20)
#           Output: 9
# Example 5 Input: @arr = (6, 6, 6, 12, 12)
#           Output: 8
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

say task(@ARGV);

#=============================================================================
sub task(@arr)
{
    use List::Util qw/sum0/;
    use POSIX qw/lround/;

    my @use = grep { $_ % 6 == 0 } @arr;

    try {
        lround( sum0(@use)/@use );
    }
    catch ( $e )
    {
        return 0;
    }
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(         18, 5, 7, 11), 18, "Example 1");
    is( task(6, 12, 18, 24, 30, 40), 18, "Example 2");
    is( task(     3, 9, 15, 21, 27),  0, "Example 3");
    is( task(        6, 12, 14, 20),  9, "Example 4");
    is( task(      6, 6, 6, 12, 12),  8, "Example 5");

    is( task( -6, -12),                -9, "Negative numbers");
    is( task( -6, -12,  -6, -12, -6),  -8, "Negative numbers round down");
    is( task( -6, -12, -18, -12, -6), -11, "Negative numbers round up");
    is( task(  1,   2,   3,   4,  5),   0, "No multiples of 6");

    done_testing;
}
