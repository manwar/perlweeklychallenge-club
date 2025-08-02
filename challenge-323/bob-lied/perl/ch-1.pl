#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 323 Task 1 Increment Decrement
#=============================================================================
# You are given a list of operations.  Write a script to return the final
# value after performing the given operations in order. The initial value
# is always 0.  Possible Operations:
# ++x or x++: increment by 1
# --x or x--: decrement by 1
# Example 1 Input: @operations = ("--x", "x++", "x++")
#           Output: 1
# Example 2 Input: @operations = ("x++", "++x", "x++")
#           Output: 3
# Example 3 Input: @operations = ("x++", "++x", "--x", "x--")
#           Output: 0
#=============================================================================

use v5.40;
use List::Util qw/sum0/;


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

say incdec(@ARGV);

#=============================================================================
sub incdec(@operations)
{
    return sum0 map { substr($_,1,1) eq '+' ? 1 : -1 } @operations;
}

sub runTest
{
    use Test2::V0;

    is( incdec("--x", "x++", "x++"),        1, "Example 1");
    is( incdec("x++", "++x", "x++"),        3, "Example 2");
    is( incdec("x++", "++x", "--x", "x--"), 0, "Example 3");
    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
