#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 350 Task 2  Shuffle Pairs
#=============================================================================
# If two integers A <= B have the same digits but in different orders, we
# say that they belong to the same shuffle pair if and only if there is an
# integer k such that A = B * k. k is called the witness of the pair.
# For example, 1359 and 9513 belong to the same shuffle pair, because
# 1359 * 7 = 9513.
#
# Interestingly, some integers belong to several different shuffle pairs.
# For example, 123876 forms one shuffle pair with 371628, and another with
# 867132, as 123876 * 3 = 371628, and 123876 * 7 = 867132.
#
# Write a function that for a given $from, $to, and $count returns the number
# of integers $i in the range $from <= $i <= $to that belong to at least
# $count different shuffle pairs.
#
# PS: Inspired by a conversation between Mark Dominus and Simon Tatham at Mastodon.
#
# Example 1 Input: $from = 1, $to = 1000, $count = 1
#           Output: 0
#   There are no shuffle pairs with elements less than 1000.
# Example 2 Input: $from = 1500, $to = 2500, $count = 1
#           Output: 3
#   There are 3 integers between 1500 and 2500 that belong to shuffle pairs.
#   1782, the other element is 7128 (witness 4)
#   2178, the other element is 8712 (witness 4)
#   2475, the other element is 7425 (witness 3)
#
# Example 3 Input: $from = 1_000_000, $to = 1_500_000, $count = 5
#           Output: 2
#   There are 2 integers in the given range that belong to 5 different shuffle pairs.
#   1428570 pairs with 2857140, 4285710, 5714280, 7142850, and 8571420
#   1429857 pairs with 2859714, 4289571, 5719428, 7149285, and 8579142
#
# Example 4 Input: $from = 13_427_000, $to = 14_100_000, $count = 2
#           Output: 11
#   6 integers in the given range belong to 3 different shuffle pairs,
#   5 integers belong to 2 different ones.
#
# Example 5 Input: $from = 1030, $to = 1130, $count = 1
#           Output: 2
#   There are 2 integers between 1020 and 1120 that belong to at least one shuffle pair:
#   1035, the other element is 3105 (witness k = 3)
#   1089, the other element is 9801 (witness k = 9)
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

say shufflePair(@ARGV);

sub canonical($n)
{
    join("", sort { $a <=> $b } split(//, $n));
}

#=============================================================================
sub shufflePair($from, $to, $count)
{
    my $answer = 0;

    for my $n ( $from .. $to )
    {
        my $base = canonical($n);
        my $max = (9 x length($n))+0;
        my $pair = 0;
        for ( 2 .. 9 )
        {
            my $multiple = $n * $_;

            next if $multiple > $max
                 || index($base, substr($multiple,  0, 1)) < 0
                 || index($base, substr($multiple, -1, 1)) < 0;

            if ( canonical($multiple) eq $base )
            {
                $pair++;
                # $logger->debug("$n*$_=$multiple base=$base pair=$pair") if $pair >= $count;
            }
        }
        $answer++ if $pair >= $count;
    }

    return $answer;
}

sub runTest
{
    use Test2::V0;

    is( shufflePair(         1,       1000, 1), 0, "Example 1");
    is( shufflePair(      1500,       2500, 1), 3, "Example 2");
    is( shufflePair( 1_000_000,  1_500_000, 5), 2, "Example 3");
    is( shufflePair(13_427_000, 14_100_000, 2), 11, "Example 4");
    is( shufflePair(      1030,       1130, 1), 2, "Example 5");

    done_testing;
}
