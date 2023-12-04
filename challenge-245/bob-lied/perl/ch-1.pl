#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 245 Task 1 Language Sort
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given two array of languages and its popularity.
# Write a script to sort the language based on popularity.
# Example 1 Input: @lang = ('perl', 'c', 'python')
#                  @popularity = (2, 1, 3)
#           Output: ('c', 'perl', 'python')
# Example 2 Input: @lang = ('c++', 'haskell', 'java')
#                  @popularity = (1, 3, 2)
#           Output: ('c++', 'java', 'haskell')
# ---------
# The @popularity array tells us where to move things.  For example 1,
# it tells us that the language in position 1 should move to position 2,
# the language in position 2 should move to position 1, and the language in
# position 3 should move to position 3.
#
# @lang       perl    c       python
#             [1]     [2]     [3]
#               \      /       |            
#              --\-----        |
#             /   +___         |
#             |       \        |
# @popularity [1]=2   [2]=1   [3]=3
#             |        |       |
# @output     c       perl    python
#             [1]     [2]     [3]
# =============================================================================

use v5.38;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;
my $DoBenchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$DoBenchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($DoBenchmark) );

sub langSort_M($lang, $popularity)
{
    my @place;
    # Use map to shift to 0-based indexing.  Use a hash slice to select where
    # each of the positions is supposed to move to.
    @place[ map { $_ - 1 } $popularity->@* ] = 0 .. $lang->$#*;
    # Return (a reference to) a hash slice of the calculated positions.
    return [ $lang->@[@place] ];
}

sub langSort_S($lang, $popularity)
{
    # Sort positions by popularity, and alphabetically if tied.
    # Use a hash slice to select the new positions.
    [ $lang->@[ sort { $popularity->[$a] <=> $popularity->[$b]
                     || $lang->[$a] cmp $lang->[$b] } 0 .. $lang->$#* ] ]
}

sub runTest
{
    use Test2::V0;

    for my $version ( \&langSort_M, \&langSort_S )
    {

    is( $version->( [<perl c python >],   [2,1,3] ), [<c perl python   >], "Example 1");
    is( $version->( ['c++', 'haskell', 'java'], [1,3,2] ), ['c++', 'java', 'haskell'], "Example 2");

    is( $version->( [qw(a b c d e)], [1..5] ), [qw(a b c d e)], "More than 3");
    is( $version->( [qw(a b c d e)], [5,4,3,2,1] ), [qw(e d c b a)], "More than 3 backwards");
    is( $version->( [qw(a b c d e)], [5,1,3,2,4] ), [qw(b d c e a)], "More than 3 shuffled");

    }

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my @name = ('a' .. 'z', 'A' .. 'Z') x 10;
    my @order =  reverse 1 .. @name;

    cmpthese($repeat, {
            "mapping" => sub { langSort_M(\@name, \@order) },
            "sorting" => sub { langSort_S(\@name, \@order) },
    });
}
