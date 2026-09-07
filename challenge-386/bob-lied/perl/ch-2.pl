#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 386 Task 2  Rational Numbers
#=============================================================================
# You are given two strings representing non-negative rational numbers.
# Write a script to return true if the two given rational numbers are same.
# Example 1 Input: $rat1 = "0.(12)" $rat2 = "0.(121)"
#           Output: false
#   Expansion of "0.(12)"  = 0.12 12 12 12
#   Expansion of "0.(121)" = 0.121 121 121
# Example 2 Input: $rat1 = "0.1(23)" $rat2 = "0.12(32)"
#           Output: true
#   Expansion of "0.1(23)"  = 0.1 23 23 23
#   Expansion of "0.12(32)" = 0.12 32 32 32
# Example 3 Input: $rat1 = "0.1(234)" $rat2 = "0.12(342)"
#           Output: true
#   Expansion of "0.1(234)"  = 0.1 234 234 234
#   Expansion of "0.12(342)" = 0.12 342 342 342
# Example 4 Input: $rat1 = "12.99(99)" $rat2 = "13."
#           Output: true
# Example 5 Input: $rat1 = "0.(123)" $rat2 = "0.1(231)"
#           Output: true
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

say task(@ARGV) ? "true" : "false";

#=============================================================================
use bigrat;
#=============================================================================
sub task($rat1, $rat2)
{
    my $r1 = asRational($rat1);
    my $r2 = asRational($rat2);

    return $r1 == $r2;
}

sub asRational($rat)
{
    my ($whole, $fixed, $repeat) = $rat =~ m/
            (\d*)       # Capture hole number part before decimal
            \.          # Decimal point
            (\d*)?      # Capture optional fixed digits
            (?:\(       # Non-capturing group for the part in parentheses
            (\d+)       # Capture repeating digits only (not the () )
            \))?        # Close parentheses group, repeat is optional
            /x;

    $fixed ||= 0;
    $repeat ||= 0;

    $logger->debug("asRational: $rat --> $whole $fixed $repeat");

    # Multiplier to move fixed to right of decimal point.
    my $multFixed  = ( $fixed ? 10 ** length($fixed)      : 1 );

    # Multiplier to move repeat to right of decimal point, minus 1
    my $multRepeat = ( $repeat ? 10 ** length($repeat) - 1 : 1 );

    # Move all digits right of decimal point. Example: 1.2(34) --> 1234.
    my $numerator   = ($whole * $multFixed + $fixed) * $multRepeat + $repeat;

    my $denominator = $multFixed * $multRepeat;

    $logger->debug("asRational: $rat --> $numerator / $denominator");

    # Returns a BigRat object, not math. Handles reducing fractions.
    return $numerator / $denominator;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task( "0.(12)"  ,   "0.(121)"), false, "Example 1");
    is( task( "0.1(23)" ,  "0.12(32)"),  true, "Example 2");
    is( task( "0.1(234)", "0.12(342)"),  true, "Example 3");
    is( task("12.99(99)",       "13."),  true, "Example 4");
    is( task( "0.(123)" ,  "0.1(231)"),  true, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
