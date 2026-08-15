#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 386 Task 1  Reverse Base
#=============================================================================
# You are given a string representing a number, and an integer specifying the
# base of that representation.  Write a function to convert this string to an
# integer. (For bases greater than 10, use characters A-Z, a-z, + and / )
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

say task(@ARGV);

#=============================================================================
sub task($num, $base)
{
    state %VALUE = do { my $v = 0; map { $_ => $v++ } ( '0'..'9', 'A'..'Z', 'a'..'z', '+', '/'); };

    my $n = 0;
    my $place = 1;
    while ( (my $d = substr($num, -1, 1, '') ) ne '' )
    {
        $n += $place * $VALUE{$d};
        $place *= $base;
    }
    return $n;
}

sub taskPOP($num, $base)
{
    state %VALUE = do { my $v = 0; map { $_ => $v++ } ( '0'..'9', 'A'..'Z', 'a'..'z', '+', '/'); };

    my @digit = split(//, $num);
    my $n = 0;
    my $place = 1;
    while ( defined(my $d = pop @digit) )
    {
        $n += $place * $VALUE{$d};
        $place *= $base;
    }
    return $n;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task("101010",  2),        42, "Example 1");
    is( task("EEADEE", 16),  15642094, "Example 2");
    is( task(   "755",  8),       493, "Example 3");
    is( task( "1BRJB", 36),   2228519, "Example 4");
    is( task( "7MyqL", 64), 123456789, "Example 5");

    is( taskPOP("101010",  2),        42, "Example 1");
    is( taskPOP("EEADEE", 16),  15642094, "Example 2");
    is( taskPOP(   "755",  8),       493, "Example 3");
    is( taskPOP( "1BRJB", 36),   2228519, "Example 4");
    is( taskPOP( "7MyqL", 64), 123456789, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            string => sub { task("123456789123456", 16) },
            array  => sub { taskPOP("123456789123456", 16) },
        });
}
