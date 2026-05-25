#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 375 Task 2  Find K-Beauty
#=============================================================================
# You are given a number and a digit (k).  Write a script to find the K-Beauty
# of the given number. The K-Beauty of an integer number is defined as the
# number of substrings of given number when it is read as a string has length
# of ‘k’ and is a divisor of given number.
# Example 1 Input: $num = 240, $k = 2
#           Output: 2
#   Substring with length 2:
#   24: 240 is divisible by 24
#   40: 240 is divisible by 40
#
# Example 2 Input: $num = 1020, $k = 2
#           Output: 3
#   Substring with length 2:
#   10: 240 is divisible by 10
#   02: 240 is divisible by 02
#   20: 240 is divisible by 20
#
# Example 3 Input: $num = 444, $k = 2
#           Output: 0
#   Substring with length 2:
#   First "44": 444 is not divisible by 44
#   Second "44": 444 is not divisible by 44
#
# Example 4 Input: $num = 17, $k = 2
#           Output: 1
#   Substring with length 2:
#   17: 17 is divisible by 17
#
# Example 5 Input: $num = 123, $k = 1
#           Output: 2
#   Substring with length 1:
#   1: 123 is divisible by 1
#   2: 123 is not divisible by 2
#   3: 123 is divisible by 3
#=============================================================================

use v5.42;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

my $K = 1;

GetOptions("k:i" => \$K, "test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
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

say findKbeauty($_, $K) for @ARGV;

#=============================================================================
sub findKbeauty($num, $k)
{
    my $len = length("$num");
    my $beauty = 0;
    for ( 0 .. $len-$k )
    {
        $beauty++ if $num % substr($num, $_, $k) == 0;
    }

    return $beauty;
}

sub fk2($num, $k)
{
    scalar grep { $num % $_ == 0 } map { substr($num, $_, $k) } 0 .. length($num)-$k;
}

sub runTest
{
    use Test2::V0;

    my @case = (
        { num =>  240, k => 2, expect => 2, desc => "Example 1" },
        { num => 1020, k => 2, expect => 3, desc => "Example 2" },
        { num =>  444, k => 2, expect => 0, desc => "Example 3" },
        { num =>   17, k => 2, expect => 1, desc => "Example 4" },
        { num =>  123, k => 1, expect => 2, desc => "Example 5" },
    );

    my @solution = (
        { func => \&findKbeauty, desc => "findKbeauty" },
        { func =>         \&fk2, desc => "fk2" },
    );

    for my $tc ( @case )
    {
        for my $f ( @solution )
        {
            is( $f->{func}($tc->{num}, $tc->{k}), $tc->{expect}, "$tc->{desc} $f->{desc}" );
        }
    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            forloop => sub { findKbeauty(1125899906842623, 3) },
            grepmap => sub {         fk2(1125899906842623, 3) },
        });
}
