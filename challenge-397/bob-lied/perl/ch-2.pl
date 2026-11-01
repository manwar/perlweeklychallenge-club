#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 397 Task 2  Binary Reflection
#=============================================================================
# You are given an array of integer.  Write a script to sort the given array
# in ascending order based on the binary reflection of each element. If two
# different numbers have the same binary reflection, the smaller original
# number should appear first.
# Example 1 Input: @arr = (3, 6, 12)
#           Output: (3, 6, 12)
#   Decimal 3  = Binary 11 -> reverse is also same 11 = Decimal 3
#   Decimal 6  = Binary 110 -> reverse 011 = Decimal 3
#   Decimal 12 = Binary 1100 -> 0011 = Decimal 3
#   All three elements have the same binary reflection (3).  Since they tie,
#   they are sorted by their original values in ascending order: (3, 6, 12).
#
# Example 2 Input: @arr = (1, 2, 4, 8)
#           Output: (1, 2, 4, 8)
#   Decimal 1 = Binary    1 -> reverse is    1 = Decimal 1
#   Decimal 2 = Binary   10 -> reverse is   01 = Decimal 1
#   Decimal 4 = Binary  100 -> reverse is  001 = Decimal 1
#   Decimal 8 = Binary 1000 -> reverse is 0001 = Decimal 1
#   All elements reflect to 1. Tie-breaking by original value yields (1, 2, 4, 8).
#
# Example 3 Input: @arr = (7, 8, 9, 10)
#           Output: (8, 10, 7, 9)
#   Decimal 8  = Binary 1000 -> reverse 0001 = Decimal 1
#   Decimal 9  = Binary 1001 -> reverse 1001 = Decimal 9
#   Decimal 10 = Binary 1010 -> reverse 0101 = Decimal 5
#   Decimal 7  = Binary 111  -> reverse 111 = Decimal 7
# Example 4 Input: @arr = (5, 9, 15, 17)
#           Output: (5, 9, 15, 17)
#   Decimal 5  = Binary 101   -> reverse 101 = Decimal 5
#   Decimal 9  = Binary 1001  -> reverse 1001 = Decimal 9
#   Decimal 15 = Binary 1111  -> reverse 1111 = Decimal 15
#   Decimal 17 = Binary 10001 -> reverse 10001 = Decimal 17
#   All numbers are binary palindromes, so their reflections match their
#   original decimal values (5, 9, 15, 17), leaving the array order unchanged.
#
# Example 5 Input: @arr = (11, 13, 14, 19)
#           Output: (14, 13, 11, 19)
#=============================================================================

use v5.44;


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

say '(', join(", ", task_LOOKUP(@ARGV)->@*), ')';

#=============================================================================
sub task_LOOKUP($arr)
{
    my %mirror = map { $_ => reflect($_) } $arr->@*;

    [ sort { $mirror{$a} <=> $mirror{$b} || $a <=> $b } $arr->@* ];
}

sub task_TRANSFORM($arr)
{
    # Schwartzian transform
    [ map { $_->[0] }
        sort { $a->[1] <=> $b->[1] || $a->[0] <=> $b->[0] }
            map { [ $_, reflect($_) ] } $arr->@*
    ]
}

use Memoize;
memoize('reflect');
sub reflect($n)
{
    return oct( reverse sprintf("%bb0", $n) );
}

sub runTest
{
    use Test2::V1 -ipP;

    is( reflect(0), 0, "reflect 0");
    is( reflect(1), 1, "reflect 1");
    is( reflect(2), 1, "reflect 1");
    is( reflect(4), 1, "reflect 1");
    is( reflect(5), 5, "reflect 1");
    is( reflect(6), 3, "reflect 1");
    is( reflect(10), 5, "reflect 10");
    is( reflect(12), 3, "reflect 12");
    is( reflect(0b1011011011), 0b1101101101, "reflect bigger number");

    is( task_LOOKUP([     3,  6, 12]), [     3,  6, 12], "Example 1");
    is( task_LOOKUP([ 1,  2,  4,  8]), [ 1,  2,  4,  8], "Example 2");
    is( task_LOOKUP([ 7,  8,  9, 10]), [ 8, 10,  7,  9], "Example 3");
    is( task_LOOKUP([ 5,  9, 15, 17]), [ 5,  9, 15, 17], "Example 4");
    is( task_LOOKUP([11, 13, 14, 19]), [14, 13, 11, 19], "Example 5");

    is( task_TRANSFORM([     3,  6, 12]), [     3,  6, 12], "Example 1");
    is( task_TRANSFORM([ 1,  2,  4,  8]), [ 1,  2,  4,  8], "Example 2");
    is( task_TRANSFORM([ 7,  8,  9, 10]), [ 8, 10,  7,  9], "Example 3");
    is( task_TRANSFORM([ 5,  9, 15, 17]), [ 5,  9, 15, 17], "Example 4");
    is( task_TRANSFORM([11, 13, 14, 19]), [14, 13, 11, 19], "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;
    my @data = (1001 .. 1100);

    cmpthese($repeat, {
            lookup    => sub { task_LOOKUP(\@data) },
            transform => sub { task_TRANSFORM(\@data) },
        });
}

