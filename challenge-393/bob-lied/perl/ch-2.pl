#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 393 Task 2  Prime Step
#=============================================================================
# You are given a string with English alphabetic characters only.  What is
# the absolute difference of the sum of the ASCII values of the characters
# in the string to the nearest prime number?
# Example 1 Input: $str = "hello" Output: 9
#   The ordinal values of "hello" are [104,101,108,108,111], summing up to 532.
#   The nearest prime number to 532 is 523, resulting in an difference of 9.
# Example 2 Input: $str = "football" Output: 2
#   Starting with the values [102,111,111,116,98,97,108,108] and the sum 841.
#   We find 839 as the nearest prime number, so the difference is 2.
# Example 3 Input: $str = "a" Output: 0
# Example 4 Input: $str = "challenge" Output: 2
#   The ordinal values of "challenge" are [99, 104, 97, 108, 108, 101, 110,
#   103, 101], which sum up to 931.
#   The nearest prime number to 931 is 929, so the difference is 2.
# Example 5 Input: $str = "perl" Output: 2
#   The ordinal values of "perl" are [112, 101, 114, 108], summing up to 435.
#   Nearest prime is 433, so the difference is 2.
#=============================================================================

use v5.44;


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

say task($_) for @ARGV;

#=============================================================================
sub task($str)
{
    use List::Util qw/sum0 min/;
    use Math::Prime::Util qw/is_prime prev_prime next_prime/;
    my $s = sum0 map { ord($_) } split //, $str;
    $logger->debug("s=$s");
    if ( is_prime($s) )
    {
        return 0;
    }
    else
    {
        my $p = prev_prime($s);
        my $n = next_prime($s);
        $logger->debug("$p -- $s -- $n");
        return min( abs($s-prev_prime($s)), abs($s-next_prime($s)) );
    }
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task("hello"),     9, "Example 1");
    is( task("football"),  2, "Example 2");
    is( task("a"),         0, "Example 3");
    is( task("challenge"), 2, "Example 4");
    is( task("perl"),      2, "Example 5");

    done_testing;
}
