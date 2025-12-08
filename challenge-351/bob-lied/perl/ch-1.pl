#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 351 Task 1  Special Average
#=============================================================================
# You are given an array of integers.  Write a script to return the average
# excluding the minimum and maximum of the given array.
# Example 1 Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
#           Output: 5250
# Example 2 Input: @ints = (100_000, 80_000, 110_000, 90_000)
#           Output: 95_000
# Example 3 Input: @ints = (2500, 2500, 2500, 2500)
#           Output: 0
# Example 4 Input: @ints = (2000)
#           Output: 0
# Example 5 Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
#           Output: 3500
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

say specAvg(@ARGV);

#=============================================================================
sub specAvg(@num)
{
    use List::Util qw/sum0/;
    use List::MoreUtils qw/minmax/;
    my ($min, $max) = minmax(@num);
    my @useful = grep { $_ != $min && $_ != $max } @num;
    return sum0(@useful)/(scalar(@useful) || 1);
}

sub runTest
{
    use Test2::V0;

    is( specAvg( 8000, 5000, 6000, 2000, 3000, 7000) ,  5250, "Example 1");
    is( specAvg(   100_000, 80_000, 110_000, 90_000) , 95000, "Example 2");
    is( specAvg(             2500, 2500, 2500, 2500) ,     0, "Example 3");
    is( specAvg(                               2000) ,     0, "Example 4");
    is( specAvg( 1000, 2000, 3000, 4000, 5000, 6000) ,  3500, "Example 5");

    done_testing;
}
