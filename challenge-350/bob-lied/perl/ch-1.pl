#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 350 Task 1  Good Substrings
#=============================================================================
# You are given a string.  Write a script to return the number of good
# substrings of length three in the given string.  A string is good if
# there are no repeated characters.
# Example 1 Input $str = "abcaefg"
#           Output: 5
#   Good substrings of length 3: abc, bca, cae, aef and efg
# Example 2 Input: $str = "xyzzabc"
#           Output: 3
# Example 3 Input: $str = "aababc"
#           Output: 1
# Example 4 Input: $str = "qwerty"
#           Output: 4
# Example 5 Input: $str = "zzzaaa"
#           Output: 0
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

say goodSubstring($_) for @ARGV;

#=============================================================================
sub goodSubstring($str)
{
    my $good = 0;
    my @s = split(//, $str);
    for ( 0 .. $#s - 2 )
    {
        my ($first, $second, $third) = @s[$_, $_+1, $_+2];
        $good++ if ( $first ne $second && $first ne $third && $second ne $third );
    }
    return $good;
}

sub runTest
{
    use Test2::V0;

    is( goodSubstring("abcaefg"), 5, "Example 1");
    is( goodSubstring("xyzzabc"), 3, "Example 2");
    is( goodSubstring("aababc"),  1, "Example 3");
    is( goodSubstring("qwerty"),  4, "Example 4");
    is( goodSubstring("zzzaaa"),  0, "Example 5");

    done_testing;
}
