#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 377 Task 1  Reverse Existence
#=============================================================================
# You are given a string.  Write a script to find whether any substring of
# length 2 is also present in the reverse of the given string.
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

for my $str ( @ARGV )
{
    say task($str) ? "true" : "false";
}

#=============================================================================
sub task($str)
{
    my $rts = reverse $str;

    for my $at ( 0 .. length($str)-2 )
    {
        return true if index($rts, substr($str, $at, 2)) >= 0;
    }
    return false;
}

sub task2($str)
{
    use List::Util qw/any/;
    my $rts = reverse $str;

    any { index($rts, substr($str, $_, 2)) >= 0 } 0 .. length($str)-2;
}

sub runTest
{
    use Test2::V0;

    is( task("abcba"),    true, "Example 1");
    is( task("racecar"),  true, "Example 2");
    is( task("abcd"),    false, "Example 3");
    is( task("banana"),   true, "Example 4");
    is( task("hello"),    true, "Example 5");

    is( task2("abcba"),    true, "Example 1");
    is( task2("racecar"),  true, "Example 2");
    is( task2("abcd"),    false, "Example 3");
    is( task2("banana"),   true, "Example 4");
    is( task2("hello"),    true, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my $str = ("abcdefghij" x 10) . "j";

    cmpthese($repeat, {
            forloop => sub { task($str)  },
            utilany => sub { task2($str) }
        });
}
