#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 310 Task 1 Arrays Intersection
#=============================================================================
# You are given a list of array of integers.
# Write a script to return the common elements in all the arrays.
# Example 1 Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
#           Output: (1, 4)
# Example 2 Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
#   `       Output: (2)
# Example 3 Input: $list = ( [1, 2, 3], [4, 5], [6] )
#           Output: ()
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

my @Arr;
push @Arr, [ split " " ] for ( @ARGV );

say '(', join(',', asect(@Arr)->@*), ')';

#=============================================================================
sub asect(@list)
{
    my %common;
    my $allBits = 2 ** scalar(@list) - 1;
    for ( 0 .. $#list )
    {
        my $bit = 1 << $_;
        $common{$_} |= $bit for $list[$_]->@*;
    }
    return [ grep { $common{$_} == $allBits } sort { $a <=> $b } keys %common ];
}

sub runTest
{
    use Test2::V0;

    is( asect( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]), [1,4], "Example 1");
    is( asect( [1, 0, 2, 3], [2, 4, 5] ),                 [  2], "Example 2");
    is( asect( [1,2,3], [4,5], [6]),                      [   ], "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

