#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 397 Task 1  Absent Smallest Positive
#=============================================================================
# You are given an array of integers.  Write a script to return the smallest
# absent positive integer such that it is strictly greater than the average
# of all elements in the given array.
# Example 1 Input: @arr = (1, 2, 4, 5, 6)
#           Output: 7
#   Average: (1 + 2 + 4 + 5 + 6) / 5 = 3.6
#   We need the smallest positive integer absent from nums that is
#   strictly greater than 3.6.
# Example 2 Input: @arr = (-5, -2, -1, 3)
#           Output: 1
#   Average: (-5 -2 -1 + 3) / 4 = -1.25
#   We need the smallest absent positive integer strictly greater than -1.25.
#   Positive integers are 1, 2, 3, 4, ... (all are strictly greater than -1.25).
#   1 is positive and absent from the given array.
# Example 3 Input: @arr = (1, 2, 3)
#           Output: 4
#   Average: (1 + 2 + 3) / 3 = 2.0.   4 is the first missing positive integer.
# Example 4 Input: @arr = (2, 3, 7, 8)
#           Output: 6
#   Average: (2 + 3 + 7 + 8) / 4 = 5.0
# Example 5 Input: @arr = (1, 1, 1, 10)
#           Output: 4
#   Average: (1 + 1 + 1 + 10) / 4 = 3.25
#   Positive integers strictly greater than 3.25: 4, 5, 6, ...
#   4 is not in the given array.
#=============================================================================

use v5.44;


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

say task(@ARGV);

#=============================================================================
sub task(@arr)
{
    if    ( @arr == 0 ) { return 1 }
    elsif ( @arr == 1 ) { return $arr[0] > 0 ? ($arr[0] + 1) : 1 };
    use List::Util qw/sum0/;

    my $start = sum0(@arr) / @arr;
    $start = 0 if $start < 0;

    @arr = ( sort { $a <=> $b } grep { $_ > $start && $_ > 0 } @arr );

    my $beg = floor($start);
    while ( defined(my $end = shift @arr) )
    {
        return $beg+1 if ( $end - $beg > 1 );
        $beg = $end;
    }
    return $beg+1;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task( 1,  2,  4, 5, 6), 7, "Example 1");
    is( task(   -5, -2, -1, 3), 1, "Example 2");
    is( task(         1, 2, 3), 4, "Example 3");
    is( task(      2, 3, 7, 8), 6, "Example 4");
    is( task(     1, 1, 1, 10), 4, "Example 5");

    is( task(200), 201, "List of one");
    is( task(   ),   1, "Empty list");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
