#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 384 Task 1  Base N
#=============================================================================
# You are given a number and a base integer.
# Write a script to convert the given number in the given base integer.
# Example 1 Input: $num = 42, $base = 2
#           Output: 101010
# Example 2 Input: $num = 15642094, $base = 16
#           Output: EEADEE
# Example 3 Input: $num = 493, $base = 8
#           Output: 755
# Example 4 Input: $num = 2228519, $base = 36
#           Output: 1BRJB
# Example 5 Input: $num = 123456789, $base = 64
#           Output: 7MyqL
#   Base 64 (using 0-9, A-Z, a-z, and extra symbols like + and /)
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

my $Base = 16;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "base:i" => \&Base);
my $logger;
{
use Log::Log4perl qw(:easy);
Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
$logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

say task($_, $Base) for @ARGV;

#=============================================================================
sub task($num, $base)
{
    state @Digit = ( "0" .. "9", "A" .. "Z", "a" .. "z", "+", "/" );

    my $output = $Digit[ $num % $base ];
    $output .= $Digit[ $num % $base ] while ( $num = int($num / $base) )
    return reverse $output;
}

sub runTest
{
use Test2::V1 -ipP;

    is( task(       42,  2),   101010, "Example 1");
    is( task( 15642094, 16), "EEADEE", "Example 2");
    is( task(      493,  8),   "755" , "Example 3");
    is( task(  2228519, 36),  "1BRJB", "Example 4");
    is( task(123456789, 64),  "7MyqL", "Example 5");

    done_testing;
}
