#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 314 Task 2 Sort Column
#=============================================================================
# You are given a list of strings of same length.
# Write a script to make each column sorted lexicographically by deleting
# any non sorted columns.  Return the total columns deleted.
# Example 1 Input: @list = ("swpc", "tyad", "azbe")
#           Output: 2
#   Column 1: "s", "t", "a" => non sorted
#   Column 2: "w", "y", "z" => sorted
#   Column 3: "p", "a", "b" => non sorted
#   Column 4: "c", "d", "e" => sorted
#   Two columns to delete to make it sorted lexicographically.
#
# Example 2 Input: @list = ("cba", "daf", "ghi")
#           Output: 1
# Example 3 Input: @list = ("a", "b", "c")
#           Output: 0
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

say sortcol(@ARGV);

#=============================================================================
sub sortcol(@str)
{
    use List::Util qw/zip/;

    # Convert the strings to lists of characters, then transpose the array.
    # In the transposed array, count lines that are not sorted.
    return scalar grep { ! isSorted($_) } zip map { [ split(//, $_) ] } @str;
}

sub isSorted($list)
{
    for ( 0 .. $list->$#* - 1 )
    {
        return false if $list->[$_+1] lt $list->[$_];
    }
    return true;
}

sub runTest
{
    use Test2::V0;

    is( sortcol( qw/swpc tyad azbe/ ), 2, "Example 1");
    is( sortcol( qw/cba  daf  ghi / ), 1, "Example 2");
    is( sortcol( qw/a    b    c   / ), 0, "Example 3");

    is( sortcol( qw/a    b    c?  / ), 0, "Spicy extra character");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
