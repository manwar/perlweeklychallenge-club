#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 393 Task 1  Pythagoras Multiplied
#=============================================================================
# You are given a positive integer n.  Find the number of all positive
# integer triplets (a, b, c) so that a^2 + b^2 = c^2 and a, b and c are
# integers <= n. Valid triples (for n=20) are
#   (3,4,5),  (4,3,5),   (5,12,13),(6,8,10),
#   (8,6,10), (8,15,17), (9,12,15),(12,5,13),
#   (12,9,15),(12,16,20),(15,8,17),(16,12,20)
# Example 1 Input: $n = 20
#           Output: 12
# Example 2 Input: $n = 7
#           Output: 2
# Example 3 Input: $n = 1
#           Output: 0
# Example 4 Input: $n = 15
#           Output: 8
# Example 5 Input: $n = 30
#           Output: 22
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

say task($_) for @ARGV;

#=============================================================================
sub task($n)
{
    my $count = 0;

    for my $c (  1 .. $n )
    {
        for my $a ( 1 .. floor(sqrt( ($c*$c -1) / 2)) )
        {
            for my $b ( $a+1 .. floor(sqrt($c*$c - $a*$a) ))
            {
                if ( $a*$a + $b*$b == $c*$c )
                {
                    # If a,b works, then so does b,a
                    $count += 2;
                    $logger->debug("count=$count ($a,$b,$c) AND ($b,$a,$c)");
                }
            }
        }
    }

    return $count;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(20), 12, "Example 1");
    is( task( 7),  2, "Example 2");
    is( task( 1),  0, "Example 3");
    is( task(15),  8, "Example 4");
    is( task(30), 22, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
