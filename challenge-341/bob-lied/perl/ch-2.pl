#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 341 Task 2  Reverse Prefix
#=============================================================================
# You are given a string, $str and a character in the given string, $char.
# Write a script to reverse the prefix upto the first occurrence of the
# given $char in the given string $str and return the new string.
# Example 1 Input: $str = "programming", $char = "g"
#           Output: "gorpramming"
# Example 2 Input: $str = "hello", $char = "h"
#           Output: "hello"
# Example 3 Input: $str = "abcdefghij", $char = "h"
#           Output: "hgfedcbaij"
# Example 4 Input: $str = "reverse", $char = "s"
#           Output: "srevere"
# Example 5 Input: $str = "perl", $char = "r"
#           Output: "repl"
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
sub revPrefix($str, $char)
{
    my $upto = index($str, $char);
    # my $prefix = substr($str, 0, 1+$upto);
    # substr($str, 0, length($prefix)) = reverse($prefix);
    return reverse( substr($str, 0, 1+$upto) ) . substr($str, $upto+1);
}

sub runTest
{
    use Test2::V0;

    is( revPrefix("programming", "g"), 'gorpramming', "Example 1");
    is( revPrefix("hello",       "h"), 'hello',       "Example 2");
    is( revPrefix("abcdefghij",  "h"), 'hgfedcbaij',  "Example 3");
    is( revPrefix("reverse",     "s"), 'srevere',     "Example 4");
    is( revPrefix("perl",        "r"), 'repl',        "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
