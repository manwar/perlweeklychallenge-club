#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 372 Task 2  Largest Substring
#=============================================================================
# You are given a string.  Write a script to return the length of the largest
# substring between two equal characters excluding the two characters. Return
# -1 if there is no such substring.
# Example 1 Input: $str = "aaaaa"
#           Output: 3 For character "a", we have substring "aaa".
# Example 2 Input: $str = "abcdeba"
#           Output: 5 For character "a", we have substring "bcdeb".
# Example 3 Input: $str = "abbc
#           Output: 0 For character "b", we have substring "".
# Example 4 Input: $str = "abcaacbc"
#           Output: 4 For "b" => "caac"; For "c" => "aacb".
# Example 5 Input: $str = "laptop"
#           Output: 2 For character "p", we have substring "to".
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
use Log::Log4perl qw(:easy);
Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
$logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

say between($_) for @ARGV;

#=============================================================================
sub between($str)
{
    my $max = 0;
    my $n = length($str);

    # Possible optimization: cache results for repeated letters. For
    # short strings, this is going to be unnecessary overhead.
    my %haveSeen;

    for my ($i, $c) ( indexed split(//, $str) )
    {
        next if $haveSeen{$c};

        # Stop if there aren't at least max characters left between.
        # For short strings, this may cost more than just finishing the loop.
        last if $i > $n - $max - 2;

        $haveSeen{$c} = true;

        my $dist = rindex($str, $c) - $i - 1;
        $max = $dist if ( $dist > $max );

        $logger->debug("[$i] $c dist=$dist max=$max");
    }
    return $max;
}

sub runTest
{
    use Test2::V0;

    is( between("aaaaa"),    3, "Example 1");
    is( between("abcdeba"),  5, "Example 2");
    is( between("abbc"),     0, "Example 3");
    is( between("abcaacbc"), 4, "Example 4");
    is( between("laptop"),   2, "Example 5");

    done_testing;
}
