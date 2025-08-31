#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 336 Task 1  Equal Group
#=============================================================================
# You are given an array of integers. Write a script to return true if the
# given array can be divided into one or more groups: each group must be of
# the same size as the others, with at least two members, and with all members
# having the same value.
# Example 1 Input: @ints = (1,1,2,2,2,2)
#           Output: true
#   Groups: (1,1), (2,2), (2,2)
# Example 2 Input: @ints = (1,1,1,2,2,2,3,3)
#           Output: false
#   Groups: (1,1,1), (2,2,2), (3,3)
# Example 3 Input: @ints = (5,5,5,5,5,5,7,7,7,7,7,7)
#           Output: true
#   Groups: (5,5,5,5,5,5), (7,7,7,7,7,7)
# Example 4 Input: @ints = (1,2,3,4)
#           Output: false
# Example 5 Input: @ints = (8,8,9,9,10,10,11,11)
#           Output: true
#   Groups: (8,8), (9,9), (10,10), (11,11)
#=============================================================================

use v5.42;
use feature 'keyword_all'; no warnings 'experimental::keyword_all';


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

say equalGroup(@ARGV) ? "true": "false";

#=============================================================================
sub equalGroup(@ints)
{
    my %freq;
    $freq{$_}++ for @ints;
    my @group = sort { $a <=> $b } values %freq;

    my $small = shift @group;
    return $small != 1 && all { $_ % $small == 0 } @group;
}

sub runTest
{
    use Test2::V0;

    is( equalGroup(1,1,2,2,2,2),              true, "Example 1");
    is( equalGroup(1,1,1,2,2,2,3),           false, "Example 2");
    is( equalGroup(5,5,5,5,5,5,7,7,7,7,7,7),  true, "Example 3");
    is( equalGroup(1,2,3,4),                 false, "Example 4");
    is( equalGroup(8,8,9,9,10,10,11,11),      true, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

