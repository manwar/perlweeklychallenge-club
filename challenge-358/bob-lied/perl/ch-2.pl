#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
#  
# ch-2.pl Perl Weekly Challenge 3358 Task 2  Encrypted String
#=============================================================================
# You are given a string $str and an integer $int.
# Write a script to encrypt the string using the algorithm - for each
# character $char in $str, replace $char with the $int th character after
# $char in the alphabet, wrapping if needed and return the encrypted string.
# Example 1 Input: $str = "abc", $int = 1
#			Output: "bcd"
# Example 2 Input: $str = "xyz", $int = 2
#			Output: "zab"
# Example 3 Input: $str = "abc", $int = 27
#			Output: "bcd"
# Example 4 Input: $str = "hello", $int = 5
#			Output: "mjqqt"
# Example 5 Input: $str = "perl", $int = 26
#			Output: "perl"
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

my $Rotate = 0;

GetOptions("rotate:i" => \$Rotate, "test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
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

say rot(join(" ", @ARGV), $Rotate);

#=============================================================================
sub rot($str, $int)
{
    my $rotate = $int % 26;
    return join "", map { enc($_, $rotate) } split(//, $str);
}

sub enc($c, $r)
{
    state @az = ( 'a' .. 'z', 'a' .. 'z' );
    state $base = ord('a');

    if ( $c =~ m/[[:alpha:]]/ )
    {
        return ( $c eq lc($c)) ? $az[ ord($c) - $base + $r ]
                               : uc(enc(lc($c), $r));
    }
    else
    {
        return $c;
    }
}

sub runTest
{
    use Test2::V0;

    is( rot("abc",   1), "bcd",   "Example 1");
    is( rot("xyz",   2),  "zab",  "Example 2");
    is( rot("abc",  27), "bcd",   "Example 3");
    is( rot("hello", 5), "mjqqt", "Example 4");
    is( rot("perl", 26), "perl",  "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

