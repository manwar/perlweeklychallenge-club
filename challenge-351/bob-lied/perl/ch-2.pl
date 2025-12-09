#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 351 Task 2  Arithmetic Progression
#=============================================================================
# You are given an array of numbers.  Write a script to return true if the
# given array can be re-arranged to form an arithmetic progression, otherwise
# return false.  A sequence of numbers is called an arithmetic progression if
# the difference between any two consecutive elements is the same.
# Example 1 Input: @num = (1, 3, 5, 7, 9)
#           Output: true
# Example 2 Input: @num = (9, 1, 7, 5, 3)
#           Output: true
# Example 3 Input: @num = (1, 2, 4, 8, 16)
#           Output: false
# Example 4 Input: @num = (5, -1, 3, 1, -3)
#           Output: true
# Example 5 Input: @num = (1.5, 3, 0, 4.5, 6)
#           Output: true
#=============================================================================

use v5.42;


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

say (isArithProg(@ARGV) ? "true" : "false");

#=============================================================================
sub isArithProg(@num)
{
    return true if @num < 3;

    @num = sort { $a <=> $b } @num;
    my $diff = $num[1] - $num[0];

    use List::Util qw/all/;
    return all { $num[$_] - $num[$_-1] == $diff } ( 2 .. $#num );
}

sub runTest
{
    use Test2::V0;

    is( isArithProg(1,3,5,7,9),  true, "Example 1");
    is( isArithProg(9,1,7,5,3),  true, "Example 2");
    is( isArithProg(1,2,4,8,16), false, "Example 3");
    is( isArithProg(5, -1, 3, 1, -3),  true, "Example 4");
    is( isArithProg(1.5, 3, 0, 4.5, 6),  true, "Example 5");

    done_testing;
}
