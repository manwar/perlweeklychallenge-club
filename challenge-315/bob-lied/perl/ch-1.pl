#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 315 Task 1 Find Words
#=============================================================================
# You are given a list of words and a character.  Write a script to return
# the index of word in the list where you find the given character.
#
# Example 1 Input: @list = ("the", "weekly", "challenge")
#                  $char = "e"
#           Output: (0, 1, 2)
#
# Example 2 Input: @list = ("perl", "raku", "python")
#                  $char = "p"
#           Output: (0, 2)
#
# Example 3 Input: @list = ("abc", "def", "bbb", "bcd")
#                  $char = "b"
#           Output: (0, 2, 3)
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

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

my $CHAR = pop @ARGV;
say '(', join(',', findWords($CHAR, @ARGV)->@*), ')';

#=============================================================================
sub findWords($char, @list)
{
    return  [ grep { index($list[$_], $char) >= 0 } 0 .. $#list ];
}

sub runTest
{
    use Test2::V0;

    is( findWords( 'e', qw/the weekly challenge/), [0,1,2], "Example 1");
    is( findWords( 'p', qw/perl raku python/    ), [0,2  ], "Example 2");
    is( findWords( 'b', qw/abc def bbb bcd/     ), [0,2,3], "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
