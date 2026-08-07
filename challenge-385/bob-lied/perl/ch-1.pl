#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 385 Task 1  Uncommon Words
#=============================================================================
# You are given two sentences.  Write a script to return list of all
# uncommon words, order is not important.
# Example 1 Input: $sentence1 = "apple banana apple" $sentence2 = "banana orange"
#           Output: ("orange")
# Example 2 Input: $sentence1 = "cat dog" $sentence2 = "bird fish"
#           Output: ("cat", "dog", "bird", "fish")
# Example 3 Input: $sentence1 = "the quick brown fox" $sentence2 = "the quick"
#           Output: ("brown", "fox")
# Example 4 Input: $sentence1 = "hello" $sentence2 = "hello"
#           Output: ()
# Example 5 Input: $sentence1 = "blue blue red" $sentence2 = "red green green yellow"
#           Output: ("yellow")
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
sub task($sentence1, $sentence2)
{
    use List::MoreUtils qw/singleton/;
    [ singleton split(" ", $sentence1), split(" ", $sentence2) ];
}

sub runTest
{
    use Test2::V1 -ipP;

    my ($sentence1, $sentence2, $expect);

    $sentence1 = "apple banana apple"; $sentence2 = "banana orange";
    $expect = [ "orange" ];
    is( task($sentence1, $sentence2), $expect, "Example 1");
    $sentence1 = "cat dog"; $sentence2 = "bird fish";
    $expect = [ "cat", "dog", "bird", "fish" ];
    is( task($sentence1, $sentence2), $expect, "Example 2");
    $sentence1 = "the quick brown fox"; $sentence2 = "the quick";
    $expect = [ "brown", "fox" ];
    is( task($sentence1, $sentence2), $expect, "Example 3");
    $sentence1 = "hello"; $sentence2 = "hello";
    $expect = [];
    is( task($sentence1, $sentence2), $expect, "Example 4");
    $sentence1 = "blue blue red"; $sentence2 = "red green green yellow";
    $expect = [ "yellow" ];
    is( task($sentence1, $sentence2), $expect, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
