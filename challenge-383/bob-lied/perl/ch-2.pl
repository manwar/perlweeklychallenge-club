#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 383 Task 2  Nearest RGB
#=============================================================================
# You are given a 6-digit hex color. Write a script to round the RGB
# channels to the nearest web-safe value and return the nearest RGB color.
# The web-safe values are
#    0x00 (0), 0x33 (51), 0x66 (102), 0x99 (153), 0xCC (204) and FF (255)
# Example 1 Input: $color = "#F4B2D1"
#           Output: "#FF99CC"
#   Red: F4 (Decimal 244), closer to 255 => FF
#   Green: B2 (Decimal 178), closer to 153 => 99
#   Blue: D1 (Decimal 209), closer to 204 => CC
#   So the nearest RGB: "#FF99CC"
#
# Example 2 Input: $color = "#15E6E5"
#           Output: "#00FFCC"
# Example 3 Input: $color = "#191A65"
#           Output: "#003366"
# Example 4 Input: $color = "#2D5A1B"
#           Output: "#336633"
# Example 5 Input: $color = "#00FF66"
#           Output: "#00FF66"
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

say $_ for @ARGV;   # TODO command line processing here

#=============================================================================
sub closest($n, @possible)
{
    my $choose = shift @possible;
    my $minDistance = abs($n - $choose);

    while ( defined(my $p = shift @possible ) )
    {
        if ( (my $diff = abs($n - $p)) < $minDistance )
        {
            $minDistance = $diff;
            $choose = $p;
        }
    }
    return $choose;
}

sub task($color)
{
    state @WebSafe = ( 0x00, 0x33, 0x66, 0x99, 0xcc, 0xff );

    my ($r, $g, $b) = map { closest(oct("0x$_"), @WebSafe) }
            ($color =~ m/([[:xdigit:]][[:xdigit:]])/g);

    return uc sprintf("#%02x%02x%02x", $r, $g, $b);
}

sub runTest
{
    use Test2::V1 -ipP;

    is( closest(7,  6, 7,  8), 7, "closest: present");
    is( closest(7,  6, 9, 10), 6, "closest: below");
    is( closest(7,  5, 8, 10), 8, "closest: above");
    is( closest(3,  5, 8, 10), 5, "closest: below left");
    is( closest(9,  5, 6,  7), 7, "closest: above right");

    is( task("#F4B2D1"), "#FF99CC", "Example 1");
    is( task("#15E6E5"), "#00FFCC", "Example 2");
    is( task("#191A65"), "#003366", "Example 3");
    is( task("#2D5A1B"), "#336633", "Example 4");
    is( task("#00FF66"), "#00FF66", "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
