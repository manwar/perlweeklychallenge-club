#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 379 Task 2  Armstrong Numbers
#=============================================================================
# You are given two integers, $base and $limit.  Write a script to find all
# Armstrong numbers in base $base that are less than $limit.
# If raising each of the digits of a nonnegative integer to the power of the
# total number of digits, then taking the sum, equals the original number,
# it is an Armstrong number.
# https://en.wikipedia.org/wiki/Narcissistic_number
#
# Example 1 Input: $base = 10, $limit = 1000
#   Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407)
# Example 2 Input: $base = 7, $limit = 1000
#   Output: (0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250)
# Example 3 Input: $base = 16, $limit = 1000
#   Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645)
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

my $Base = 10;

GetOptions("base:i" => \$Base,
    "test" => \$DoTest, "verbose" => \$Verbose, "compare:i" => \$Benchmark);
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

say join(", ", armstrong($Base, $_)->@*) for @ARGV;

#=============================================================================
use feature 'class'; no warnings "experimental::class";

class BaseConverter {

    use Math::Base::Convert;

    field $base :reader :param //= 10;;
    field $decToBase;
    field $baseToDec;

    ADJUST {
        state  @Digit = ( 0..9, 'a' .. 'z' );
        my $baseDigit = [ @Digit[0 .. $base-1] ];
        $decToBase = Math::Base::Convert->new('dec', $baseDigit);
        $baseToDec = Math::Base::Convert->new($baseDigit, 'dec');
    }

    method asBase($n) { scalar $decToBase->cnv($n) }
    method asValue($b) { $baseToDec->cnv($b) }
}

sub armstrong($base, $limit)
{
    my $cnv = BaseConverter->new(base => $base);
    my @result = (0);

    for ( my $n = 1; $n <= $limit ; $n++ )
    {
        push @result, $n if isArmstrong($n, $cnv)
    }

    return \@result;
}

sub isArmstrong($n, $baseConverter)
{
    use List::Util qw/sum/;

    my $inBase = $baseConverter->asBase($n);
    my @digit = split(//, $inBase);
    my $exponent = scalar(@digit);
    my $sum = sum map { $baseConverter->asValue($_) ** $exponent } @digit;
    return $sum == $n;
}

sub runTest
{
    use Test2::V1 -ipP;

    my $bc = BaseConverter->new(base => 5);
    is( $bc->asBase(1),    "1", "1 base 5");
    is( $bc->asBase(5),   "10", "5 base 5");
    is( $bc->asBase(25), "100", "25 base 5");
    is( $bc->asBase(31), "111", "31 base 5");
    is( $bc->asValue("111"), 31, "dec to base");
    is( $bc->asValue($bc->asBase(40)), 40, "round trip");


    is( armstrong(10, 1000), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407], "Example 1");
    is( armstrong( 7, 1000), [0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250], "Example 2");
    is( armstrong(16, 1000), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645], "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
