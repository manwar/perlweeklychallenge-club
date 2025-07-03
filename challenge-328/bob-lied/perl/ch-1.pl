#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 328 Task 1  Replace all ?
#=============================================================================
# You are given a string containing only lower case English letters and ?.
# Write a script to replace all ? in the given string so that the string
# doesn’t contain consecutive repeating characters.
# Example 1 Input: $str = "a?z"
#           Output: "abz"
#   There can be many strings, one of them is "abz". The choices are 'a'
#   to 'z' but we can't use either 'a' or 'z' to replace the '?'.
# Example 2 Input: $str = "pe?k"
#           Output: "peak"
# Example 3 Input: $str = "gra?te"
#           Output: "grabte"
#=============================================================================

use v5.40;


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

my %replace = ( "a?a" => "b", "a?b" => "c",
                "b?b" => "a", "b?a" => "c", );

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say replaceQ($_) for @ARGV;

#=============================================================================
sub replaceQ($str)
{
    my $pos = 0;
    while ( ($pos = index($str, "?", $pos)) != -1 )
    {
        my $before = substr($str, $pos-1, 1);
        my $after  = substr($str, $pos+1, 1);

        my $instead = ( $before eq 'a' || $after eq 'a' ) ? 'b' : 'a';
        $instead = 'c' if ( $before eq $instead || $after eq $instead );

        substr($str, $pos, 1, $instead);
    }
    return $str;
}

sub runTest
{
    use Test2::V0;

    is( replaceQ("a?z"   ), "abz"   , "Example 1");
    is( replaceQ("pe?k"  ), "peak"  , "Example 2");
    is( replaceQ("gra?te"), "grabte", "Example 3");

    is( replaceQ("abcde" ), "abcde" , "No question marks");
    is( replaceQ("?abcd" ), "babcd" , "Leading");
    is( replaceQ("abcd?" ), "abcda" , "Trailing");
    is( replaceQ("a?b"   ), "acb"   , "Can't be a or b");
    is( replaceQ("x???z" ), "xabaz" , "Multiple question marks");

    done_testing;
}

sub runBenchmark($repeat)
{
use Benchmark qw/cmpthese/;

cmpthese($repeat, {
label => sub { },
});
}

