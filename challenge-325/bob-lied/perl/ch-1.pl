#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 325 Task 1 Consecutive One
#=============================================================================
# You are given a binary array containing only 0 or/and 1.
# Write a script to find out the maximum consecutive 1 in the given array.
# Example 1 Input: @binary = (0, 1, 1, 0, 1, 1, 1)
#           Output: 3
# Example 2 Input: @binary = (0, 0, 0, 0)
#           Output: 0
# Example 3 Input: @binary = (1, 0, 1, 0, 1, 1)
#           Output: 2
#=============================================================================

use v5.40;
use List::Util qw/max/;

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

say consecutive(@ARGV);

#=============================================================================
sub consecutive(@binary)
{
    my $count = 0;
    my $maxConsecutive = 0;
    for ( @binary )
    {
        if ( $_ )
        {
            $maxConsecutive = $count if ++$count > $maxConsecutive;
        }
        else
        {
            $count = 0;
        }
    }
    return $maxConsecutive;
}

sub flipflop(@binary)
{
    my $max = my $count = 0;
    for ( @binary )
    {
        if ( $_==1 .. $_==1 )
        {
            $max = $count if ++$count > $max;
        }
        else
        {
            $count = 0;
        }
    }
    return $max;
}

sub asString(@binary)
{
    return max(map { length($_) } ( join('', @binary) =~ m/1+/g )) // 0;
}

sub runTest
{
    use Test2::V0;

    for my $func ( \&consecutive, \&flipflop, \&asString )
    {
    is( $func->(0, 1, 1, 0, 1, 1, 1), 3, "Example 1");
    is( $func->(0, 0, 0, 0         ), 0, "Example 2");
    is( $func->(1, 0, 1, 0, 1, 1   ), 2, "Example 3");

    is( $func->(                   ), 0, "Empty list");
    is( $func->(0                  ), 0, "One zero");
    is( $func->(1                  ), 1, "One one");
    is( $func->(1, 1, 1, 1, 1, 1, 1), 7, "All one");
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my @binary = map { int(rand(2)) } 1 .. 1000;

    cmpthese($repeat, {
            loop    => sub { consecutive(@binary) },
            fliplop => sub { flipflop(@binary) },
            string  => sub { asString(@binary) },
        });
}
