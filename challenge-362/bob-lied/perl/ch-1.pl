#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 362 Task 1  Echo Chamber
#=============================================================================
# You are given a string containing lowercase letters.
# Write a script to transform the string based on the index position of
# each character (starting from 0). For each character at position i, repeat it i + 1 times.
# 
#=============================================================================
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

foreach ( @ARGV )
{
    say "MAP: ", echoMap($_);
    say "STR: ", echoStr($_);
    say "RE:  ", echoStr($_);
}

#=============================================================================
sub echoMap($str)
{
    return join "", map { substr($str, $_-1, 1) x $_} 1 .. length($str)
}

sub echoStr($str)
{
    my $result = "";
    for my ($i, $c) ( indexed split(//, $str) )
    {
        $result .= ($c x ($i+1));
    }
    return $result;
}

sub echoRE($str)
{
    use English;
    return $str =~ s/(.)/$1 x $LAST_MATCH_END[1]/ger;
}

sub runTest
{
    use Test2::V0;

    is( echoMap( "abca"), "abbcccaaaa",      "Example 1");
    is( echoMap(  "xyz"), "xyyzzz",          "Example 2");
    is( echoMap( "code"), "coodddeeee",      "Example 3");
    is( echoMap("hello"), "heelllllllooooo", "Example 4");
    is( echoMap(    "a"), "a",               "Example 5");

    is( echoStr( "abca"), "abbcccaaaa",      "Example 1");
    is( echoStr(  "xyz"), "xyyzzz",          "Example 2");
    is( echoStr( "code"), "coodddeeee",      "Example 3");
    is( echoStr("hello"), "heelllllllooooo", "Example 4");
    is( echoStr(    "a"), "a",               "Example 5");

    is( echoRE( "abca"), "abbcccaaaa",      "Example 1");
    is( echoRE(  "xyz"), "xyyzzz",          "Example 2");
    is( echoRE( "code"), "coodddeeee",      "Example 3");
    is( echoRE("hello"), "heelllllllooooo", "Example 4");
    is( echoRE(    "a"), "a",               "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            mapjoin  => sub { echoMap("abcdefghij") for 1..100 },
            splitstr => sub { echoStr("abcdefghij") for 1..100 },
            regex    => sub {  echoRE("abcdefghij") for 1..100 },
        });
}
