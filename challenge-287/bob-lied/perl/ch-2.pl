#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 287 Task 2 Valid Number
#=============================================================================
# You are given a string, $str.
# Write a script to find if it is a valid number.
# Conditions for a valid number:
#   - An integer number followed by an optional exponent.
#   - A decimal number followed by an optional exponent.
#   - An integer number is defined with an optional sign
#     '-' or '+' followed by digits.
# Decimal Number:
# A decimal number is defined with an optional sign '-' or '+' followed by
# one of the following definitions:
#   - Digits followed by a dot '.'.
#   - Digits followed by a dot '.' followed by digits.
#   - A dot '.' followed by digits.
# Exponent:
# An exponent is defined with an exponent notation 'e' or 'E' followed by
# an integer number.
#
# Example 1 Input: $str = "1"       Output: true
# Example 2 Input: $str = "a"       Output: false
# Example 3 Input: $str = "."       Output: false
# Example 4 Input: $str = "1.2e4.2" Output: false
# Example 5 Input: $str = "-1."     Output: true
# Example 6 Input: $str = "+1E-8"   Output: true
# Example 7 Input: $str = ".44"     Output: true
#=============================================================================

use v5.40;

use Regexp::Common qw/number/;
my $NumRE = qr/^$RE{num}{real}$/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

sub bToStr($bool) { $bool ? "true" : "false" }
say bToStr(validNumber($_)) for @ARGV;

sub validNumber($str)
{
    use Scalar::Util qw/looks_like_number/;
    return looks_like_number($str);
}

sub vn2($str)
{
    $str =~ m/$NumRE/;
}

sub vn3($str)
{
    $str =~ m/^[+-]?(?:\d+\.?\d*|\.\d+)([eE][+-]?\d+)?$/
}

# https://stackoverflow.com/questions/12643009/regular-expression-for-floating-point-numbers
sub vn4($str)
{
    $str =~ m/^ # Anchored at beginning for complete string
        [+-]?   # Optional leading sign
        (?:     # Non-capturing group for alternatives
            # First alternative
            \d+ # One or more digits
            (?:[.]\d*)?  # Optional decimal point and decimals
            (?:[eE][+-]?\d+)?   # Optional signed integer exponent
          | # OR second alternative
            [.]\d+ # Optional fraction (e.g. .302)
            (?:[eE][+-]?\d+)? # Optional exponent (eg .302e-7)
        )
        $ # Anchored at end for complete match
        /x # Explanation mode
}

sub runTest
{
    use Test2::V0;

    is( validNumber("1"),       true,  "Example 1");
    is( validNumber("a"),       false, "Example 2");
    is( validNumber("."),       false, "Example 3");
    is( validNumber("1.2e4.2"), false, "Example 4");
    is( validNumber("-1."),     true,  "Example 5");
    is( validNumber("+1E-8"),   true,  "Example 6");
    is( validNumber(".44"),     true,  "Example 7");

    is( vn2("1"),       true,  "Example 1 vn2");
    is( vn2("a"),       false, "Example 2 vn2");
    is( vn2("."),       false, "Example 3 vn2");
    is( vn2("1.2e4.2"), false, "Example 4 vn2");
    is( vn2("-1."),     true,  "Example 5 vn2");
    is( vn2("+1E-8"),   true,  "Example 6 vn2");
    is( vn2(".44"),     true,  "Example 7 vn2");

    is( vn3("1"),       true,  "Example 1 vn3");
    is( vn3("a"),       false, "Example 2 vn3");
    is( vn3("."),       false, "Example 3 vn3");
    is( vn3("1.2e4.2"), false, "Example 4 vn3");
    is( vn3("-1."),     true,  "Example 5 vn3");
    is( vn3("+1E-8"),   true,  "Example 6 vn3");
    is( vn3(".44"),     true,  "Example 7 vn3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;
    my @case = qw(1 a . 1.se4.2 -1. +1E-8 .44);

    cmpthese($repeat, {
            scalar => sub { validNumber($_) for @case },
            common => sub { vn2($_) for @case },
            regex  => sub { vn3($_) for @case },
        });
}

