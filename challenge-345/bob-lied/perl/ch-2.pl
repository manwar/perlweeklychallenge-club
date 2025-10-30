#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 345 Task 2  Last Visitor
#=============================================================================
# You are given an integer array @ints where each element is either a
# positive integer or -1.  We process the array from left to right while
# maintaining two lists:
#   @seen: stores previously seen positive integers (newest at the front)
#   @ans: stores the answers for each -1
#
# Rules:
#   If $ints[i] is a positive number -> insert it at the front of @seen
#   If $ints[i] is -1:
#       Let $x be how many -1s in a row we’ve seen before this one.
#       If $x < len(@seen) -> append seen[x] to @ans
#       Else -> append -1 to @ans
#
# At the end, return @ans.
#
# Example 1 Input: @ints = (5, -1, -1)
#           Output: (5, -1)
#       @seen = (5)
#       First  -1: @ans = (5)
#       Second -1: @ans = (5, -1)
# Example 2 Input: @ints = (3, 7, -1, -1, -1)
#           Output: (7, 3, -1)
#       @seen = (3, 7)
#       First  -1: @ans = (7)
#       Second -1: @ans = (7, 3)
#       Third  -1: @ans = (7, 3, -1)
# Example 3 Input: @ints = (2, -1, 4, -1, -1)
#           Output: (2, 4, 2)
# Example 4 Input: @ints = (10, 20, -1, 30, -1, -1)
#           Output: (20, 30, 20)
# Example 5 Input: @ints = (-1, -1, 5, -1)
#           Output: (-1, -1, 5)
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

say '(', join(", ", lastVisitor(@ARGV)->@*), ')';

#=============================================================================
sub lastVisitor(@int)
{
    my @seen = ();
    my @ans  = ();

    my $x = 0;  # Count of consecutive -1s
    for ( @int )
    {
        if ( $_ > 0 )
        {
            $x = 0;
            unshift @seen, $_;
        }
        else
        {
            if ( $x < @seen )
            {
                push @ans, $seen[$x];
            }
            else
            {
                push @ans, -1;
            }
            $x++;
        }
    }
    return \@ans;
}

sub runTest
{
    use Test2::V0;

    is( lastVisitor( 5, -1, -1            ), [ 5, -1    ], "Example 1");
    is( lastVisitor( 3,  7, -1, -1, -1    ), [ 7,  3, -1], "Example 2");
    is( lastVisitor( 2, -1,  4, -1, -1    ), [ 2,  4,  2], "Example 3");
    is( lastVisitor(10, 20, -1, 30, -1, -1), [20, 30, 20], "Example 4");
    is( lastVisitor(-1, -1,  5, -1        ), [-1, -1,  5], "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
