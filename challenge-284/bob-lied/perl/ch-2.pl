#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 284 Task 2 Relativre Sort
#=============================================================================
# You are given two list of integers, @list1 and @list2. The elements
# in the @list2 are distinct and also in the @list1.
# Write a script to sort the elements in the @list1 such that the relative
# order of items in @list1 is same as in the @list2. Elements that is
# missing in @list2 should be placed at the end of @list1 in ascending order.
# Example 1 Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
#                  @list2 = (2, 1, 4, 3, 5, 6)
#           Output: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)
# Example 2 Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
#                  @list2 = (1, 3, 2)
#           Output: (1, 3, 3, 3, 2, 2, 4, 4, 6)
# Example 3 Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
#                  @list2 = (1, 0, 3, 2)
#           Output: (1, 1, 1, 0, 0, 3, 2, 4, 5)
#=============================================================================

use v5.40;
use List::MoreUtils qw/part/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

sub strToList($str)
{
    [ split(" ", ($str =~ s/\D+/ /gr)) ]
}
say "(", join(", ", relsort( strToList($ARGV[0]), strToList($ARGV[1]))->@*), ")";

sub relsort($list1, $list2)
{
    # Invert list2 so that it maps a number to its order
    my %order;
    my $place = 0;
    $order{$_} = $place++ for $list2->@*;

    # Partition list1 into two parts:
    # p[0] -- those that don't exist in list2
    # p[1] -- those that exist in list2
    my @p = List::MoreUtils::part { exists $order{$_} } $list1->@*;

    my @result;
    if ( defined $p[1] )
    {
        push @result, sort { $order{$a} <=> $order{$b} } $p[1]->@*;
    }
    if ( defined $p[0] )
    {
        push @result, sort { $a <=> $b } $p[0]->@*;
    }
    return \@result;
}

sub runTest
{
    use Test2::V0;
    my @list1; my @list2; my @output;

    @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5);
    @list2 = (2, 1, 4, 3, 5, 6);
    @output =  (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9);
    is( relsort(\@list1, \@list2), \@output, "Example 1");
 
    @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3);
    @list2 = (1, 3, 2);
    @output = (1, 3, 3, 3, 2, 2, 4, 4, 6);
    is( relsort(\@list1, \@list2), \@output, "Example 2");

    @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1);
    @list2 = (1, 0, 3, 2);
    @output = (1, 1, 1, 0, 0, 3, 2, 4, 5);
    is( relsort(\@list1, \@list2), \@output, "Example 3");

    @list1 = ( 1 .. 5 );
    @list2 = ( 5, 4, 3, 2, 1 );
    @output = ( 5, 4, 3, 2, 1 );
    is( relsort(\@list1, \@list2), \@output, "No leftovers");

    @list1 = ( 1 .. 5 );
    @list2 = ( 7 .. 9 );
    @output = ( 1 .. 5 );
    is( relsort(\@list1, \@list2), \@output, "All leftovers");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
