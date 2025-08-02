#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 327 Task 1  Missing Integers
#=============================================================================
# You are given an array of n integers.  Write a script to find all the
# missing integers in the range 1..n in the given array.
# Example 1 Input: @ints = (1, 2, 1, 3, 2, 5)
#           Output: (4, 6)
#   The given array has 6 elements.  So we are looking for integers in the
#   range 1..6 in the given array.  The missing integers: (4, 6)
# Example 2 Input: @ints = (1, 1, 1)
#           Output: (2, 3)
# Example 3 Input: @ints = (2, 2, 1)
#           Output: (3)
#=============================================================================

use v5.40;


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

say '(', join(', ', missing(@ARGV)), ')';

#=============================================================================
sub missing($ints)
{
    my @present = (true, (false) x @$ints);
    $present[$_] = true for @$ints;
    return [ grep { not $present[$_] } 1 .. $#present ];
}

sub missing_bv($ints)
{
    my $present = "";
    vec($present, $_, 1) = 1 for 0, @$ints;
    return [ grep { vec($present, $_, 1) == 0 } 1 .. @$ints ];
}


sub runTest
{
    use Test2::V0;

    is( missing([1,2,1,3,2,5]), [4,6], "Example 1");
    is( missing([1,1,1])      , [2,3], "Example 2");
    is( missing([2,2,1])      , [3  ], "Example 3");

    is( missing_bv([1,2,1,3,2,5]), [4,6], "Example 1");
    is( missing_bv([1,1,1])      , [2,3], "Example 2");
    is( missing_bv([2,2,1])      , [3  ], "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my @ints = 1 .. 1000;
    $ints[$_] = 1 for ( map { int(rand(1000)) } 1 .. 25 );
    cmpthese($repeat, {
            array  => sub { missing(\@ints) },
            bitvec => sub { missing_bv(\@ints) },
        });
}
