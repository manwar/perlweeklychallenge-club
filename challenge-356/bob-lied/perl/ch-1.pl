#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 356 Task 1 Kolakoski Sequence
#=============================================================================
# You are given an integer, $int > 3.  Write a script to generate the
# Kolakoski Sequence of given length $int and return the count of 1 in
# the generated sequence.
# https://en.wikipedia.org/wiki/Kolakoski_sequence
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

say kolakoski($_) for @ARGV;

#=============================================================================
sub kolakoski($n)
{
    my @k = ( 1, 2, 2 );
    my $term = 2;
    while ( @k < $n )
    {
        my $length   = $k[$term];

        # Digits alternate between 1 and 2
        my $digit = $term++ % 2 + 1;

        my @run = ($digit) x $length;

        $logger->debug(" K: @k (@run)");
        push @k, @run;

    }
    return scalar grep { $_ == 1 } @k[0..$n-1];
}

sub runTest
{
    use Test2::V0;

    is( kolakoski(4), 2, "Example 1");
    is( kolakoski(5), 3, "Example 2");
    is( kolakoski(6), 3, "Example 3");
    is( kolakoski(7), 4, "Example 4");
    is( kolakoski(8), 4, "Example 5");

    done_testing;
}
