#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 319 Task 2 Minimum Common
#=============================================================================
# You are given two arrays of integers. Write a script to return the minimum
# integer common to both arrays. If none found return -1.
# Example 1 Input: @array_1 = (1, 2, 3, 4)
#                  @array_2 = (3, 4, 5, 6)
#           Output: 3
#   The common integer in both arrays: 3, 4
#   The minimum is 3.
# Example 2 Input: @array_1 = (1, 2, 3)
#                  @array_2 = (2, 4)
#           Output: 2
# Example 3 Input: @array_1 = (1, 2, 3, 4)
#                  @array_2 = (5, 6, 7, 8)
#           Output: -1
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

say mincom( [split(/[\D]/, $ARGV[0])], [split(/[\D]/, $ARGV[1])]);

#=============================================================================
sub mincom($list1, $list2)
{
    use Array::Utils qw/intersect/;
    use List::Util qw/min/;
    return min(intersect(@$list1, @$list2)) // -1;
}

sub mincom_nolib($list1, $list2)
{
    return -1 unless $list1->@* && $list2->@*;
    my %inList1 = map { $_ => 0 } $list1->@*;
    my $min;
    foreach ( $list2->@* )
    {
        $min = $_ if ( exists($inList1{$_}) && ( !defined($min) || $_ < $min ) );
    }
    return $min // -1;
}

sub runTest
{
    use Test2::V0;

    is( mincom([1,2,3,4],[3,4,5,6]),  3, "Example 1");
    is( mincom([1,2,3  ],[2,4    ]),  2, "Example 2");
    is( mincom([1,2,3,4],[5,6,7,8]), -1, "Example 3");

    is( mincom([       ],[2,4,6  ]), -1, "Empty list 1");
    is( mincom([3,5,7  ],[       ]), -1, "Empty list 2");
    is( mincom([2,2,4,4],[1,2,3,4]),  2, "Non-unique list 1");
    is( mincom([1,2,3,4],[4,4,6,6]),  4, "Non-unique list 2");

    is( mincom_nolib([1,2,3,4],[3,4,5,6]),  3, "Example 1");
    is( mincom_nolib([1,2,3  ],[2,4    ]),  2, "Example 2");
    is( mincom_nolib([1,2,3,4],[5,6,7,8]), -1, "Example 3");

    is( mincom_nolib([       ],[2,4,6  ]), -1, "Empty list 1");
    is( mincom_nolib([3,5,7  ],[       ]), -1, "Empty list 2");
    is( mincom_nolib([2,2,4,4],[1,2,3,4]),  2, "Non-unique list 1");
    is( mincom_nolib([1,2,3,4],[4,4,6,6]),  4, "Non-unique list 2");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my @list1 = map { int(rand(100)) } 1..1000;
    my @list2 = map { int(rand(100)) } 1..1000;

    cmpthese($repeat, {
            withlib => sub { mincom(\@list1, \@list2) },
            nolib   => sub { mincom_nolib(\@list1, \@list2) },
        });
}
