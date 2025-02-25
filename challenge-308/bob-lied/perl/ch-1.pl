#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 308 Task 1 Count Common
#=============================================================================
# You are given two array of strings, @str1 and @str2.
# Write a script to return the count of common strings in both arrays.
# Example 1 Input: @str1 = ("perl", "weekly", "challenge")
#                  @str2 = ("raku", "weekly", "challenge")
#           Output: 2
# Example 2 Input: @str1 = ("perl", "raku", "python")
#                  @str2 = ("python", "java")
#           Output: 1
# Example 3 Input: @str1 = ("guest", "contribution")
#                  @str2 = ("fun", "weekly", "challenge")
#           Output: 0
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

my @Str = map { [ split(" ", $_) ] } @ARGV;
#say countCommon(@Str);
say generalize(@Str);

#=============================================================================
sub countCommon($str1, $str2)
{
    my %common;
    $common{$_}  = 1 for $str1->@*;
    $common{$_} |= 2 for $str2->@*;
    return scalar grep { $common{$_} == 3 } keys %common;
}

sub generalize(@str)
{
    my $allBits = 2**(scalar(@str)) - 1;
    my %common;
    for my ($i, $list) ( indexed @str )
    {
        my $bit = 1 << ($i);
        $common{$_} |= $bit for $list->@*;
    }
    my @word = grep { $common{$_} == $allBits } keys %common;
    if ( $Verbose ) { $logger->info("Common words are: ", join(" ", sort @word)) }
    return scalar @word;
}

sub runTest
{
    use Test2::V0;

    is( countCommon([ qw(perl weekly challenge) ],[ qw(raku weekly challenge) ]), 2, "Example 1");
    is( countCommon([ qw(perl raku python)      ],[ qw(python java)           ]), 1, "Example 2");
    is( countCommon([ qw(guest congribution)    ],[ qw(fun weekly challenge)  ]), 0, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
