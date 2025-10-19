#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 343 Task 1  Zero Friend
#=============================================================================
# You are given a list of numbers.
# Find the number that is closest to zero and return its distance to zero.
# Example 1 Input: @nums = (4, 2, -1, 3, -2)
#           Output: 1
# Example 2 Input: @nums = (-5, 5, -3, 3, -1, 1)
#           Output: 1
# Example 3 Input: @ums = (7, -3, 0, 2, -8)
#           Output: 0
# Example 4 Input: @nums = (-2, -5, -1, -8)
#           Output: 1
# Example 5 Input: @nums = (-2, 2, -4, 4, -1, 1)
#           Output: 1
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

say zeroFriend(@ARGV);

#=============================================================================
sub zeroFriend(@num)
{
    use List::Util qw/min/;
    return min map { abs($_) } @num;
}

sub runTest
{
    use Test2::V0;

    is( zeroFriend( 4, 2, -1, 3, -2    ) , 1, "Example 1");
    is( zeroFriend( -5, 5, -3, 3, -1, 1) , 1, "Example 2");
    is( zeroFriend( 7, -3, 0, 2, -8    ) , 0, "Example 3");
    is( zeroFriend( -2, -5, -1, -8     ) , 1, "Example 4");
    is( zeroFriend( -2, 2, -4, 4, -1, 1) , 1, "Example 5");
    is( zeroFriend( -3, -7, 100, 1.5   ) , 1.5, "Something other than 1 or 0");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
