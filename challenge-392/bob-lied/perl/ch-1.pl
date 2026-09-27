#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 392 Task 1  Convert Palindrome
#=============================================================================
# You are given a string.  Write a script to convert the given string to
# palindrome by adding characters in front of it.
# Example 1 Input: $str = "pinnipeds" Output: "sdepinnipeds"
# Example 2 Input: $str = "abcd" Output: "dcbabcd"
# Example 3 Input: $str = "bananas" Output: "sananabananas"
# Example 4 Input: $str = "dissident" Output: "tnedissident"
# Example 5 Input: $str = "cailliachs" Output: "shcailliachs"
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

say task($_) for @ARGV;

#=============================================================================
sub task($str)
{
    my $prefix = "";
    my $copy = my $p = $str;
    while ( ! is_palindrome($p) )
    {
        $prefix .= substr($copy, -1, 1, "");
        $p = "$prefix$str";
    }
    return $p;
}

sub is_palindrome($w)
{
    my ($beg, $end) = (0, length($w)-1);

    my $isPalindrome = true;
    while ( $beg < $end && $isPalindrome )
    {
        $isPalindrome &&= (substr($w, $beg++, 1) eq substr($w, $end--, 1));
    }
    return $isPalindrome;
}

sub runTest
{
    use Test2::V1 -ipP;

    ok(   is_palindrome("A"), "A");
    ok( ! is_palindrome("BA"), "BA");
    ok(   is_palindrome("ABA"), "ABA");
    ok(   is_palindrome("ABBA"), "ABBA");
    ok( ! is_palindrome("ABBAC"), "ABBAC");

    is( task( "pinnipeds"), "sdepinnipeds",  "Example 1");
    is( task(      "abcd"), "dcbabcd",       "Example 2");
    is( task(   "bananas"), "sananabananas", "Example 3");
    is( task( "dissident"), "tnedissident",  "Example 4");
    is( task("cailliachs"), "shcailliachs",  "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
