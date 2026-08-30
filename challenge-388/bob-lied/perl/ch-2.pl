#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 388 Task 2  Secret Santa
#=============================================================================
# A company with $n employees is running a Secret Santa exchange. Each
# employee buys one gift and receives one gift.  Write a script to return
# the total number of valid gift assignments where no employee receives the
# gift they originally bought (i.e., employee $i must not be assigned gift $i).
# Example 1 Input: $n = 1 Output: 0
# Example 2 Input: $n = 2 Output: 1
# Example 3 Input: $n = 3 Output: 2
# Example 4 Input: $n = 4 Output: 9
# Example 5 Input: $n = 5 Output: 44
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

say "n=$_: ", task($_) for @ARGV;

#=============================================================================
sub task($n)
{
    use Algorithm::Combinatorics qw/derangements/;
    return my $count =()= derangements( [ 1 .. $n ] );
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(1),  0, "Example 1");
    is( task(2),  1, "Example 2");
    is( task(3),  2, "Example 3");
    is( task(4),  9, "Example 4");
    is( task(5), 44, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
