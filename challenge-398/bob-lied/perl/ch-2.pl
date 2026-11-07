#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 398 Task 2  String Difference
#=============================================================================
# You are given an array of equal length strings.  Write a script to find
# the difference integer array of each word in the given array. There will
# be one word with a different array; return that word.
#
# Each words[i] can be converted into a difference integer array
# difference[i] of length n - 1
# where difference[i][j] = words[i][j+1] - words[i][j]
#
# Example 1 Input: @words = ("ab", "bc", "cd", "zy")
#           Output: "zy"
#   "ab" => [1 - 0]   = [ 1]
#   "bc" => [2 - 1]   = [ 1]
#   "cd" => [3 - 2]   = [ 1]
#   "zy" => [24 - 25] = [-1]
#
# Example 2 Input: @words = ("cba", "fed", "azy")
#           Output: "azy"
#   "cba" => [1 - 2, 0 - 1]    = [-1, -1]
#   "fed" => [4 - 5, 3 - 4]    = [-1, -1]
#   "azy" => [25 - 0, 24 - 25] = [25, -1]
#
# Example 3 Input: @words = ("pop", "ada", "beb", "cfc")
#           Output: "pop"
#   "pop" => [14 - 15, 15 - 14] = [-1,  1]
#   "ada" => [3 - 0, 0 - 3]     = [ 3, -3]
#   "beb" => [4 - 1, 1 - 4]     = [ 3, -3]
#   "cfc" => [5 - 2, 2 - 5]     = [ 3, -3]
#
# Example 4 Input: @words = ("aaaa", "zzzz", "mmmm", "aaba")
#           Output: "aaba"
#   "aaaa" => [0 - 0, 0 - 0, 0 - 0]       = [0,  0,  0]
#   "zzzz" => [25 - 25, 25 - 25, 25 - 25] = [0,  0,  0]
#   "mmmm" => [12 - 12, 12 - 12, 12 - 12] = [0,  0,  0]
#   "aaba" => [0 - 0, 1 - 0, 0 - 1]       = [0,  1, -1]
#
# Example 5 Input: @words = ("aceg", "bdfh", "cegi", "azbz")
#           Output: "azbz"
#   "aceg" => [2 - 0, 4 - 2, 6 - 4] = [2, 2, 2]
#   "bdfh" => [3 - 1, 5 - 3, 7 - 5] = [2, 2, 2]
#   "cegi" => [4 - 2, 6 - 4, 8 - 6] = [2, 2, 2]
#   "azbz" => [25 - 0, 1 - 25, 25 - 1] = [25, -24, 24]
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

my $different = task(@ARGV);
say ($different // "no unique word");

#=============================================================================
sub task(@words)
{
    # For each column of a stack of words
    for my $c ( 1 .. length($words[0])-1 )
    {
        # List of character differences at that position
        my @col = map { ord(substr($_, $c, 1)) - ord(substr($_, $c-1, 1)) } @words;

        if ( defined( my $where = uniqueIndex(@col)) )
        {
            return $words[$where];
        }
    }
    return undef;
}

# Given a list that has a unique element, return the index of
# the unique element
sub uniqueIndex(@list)
{
    use enum qw(COUNT WHERE);
    my %freq;
    for my ($i, $w) (indexed @list)
    {
        $freq{$w}[COUNT]++;
        $freq{$w}[WHERE] = $i;
    }

    my ($u) =  grep { $freq{$_}[COUNT] == 1 } @list;
    return defined($u) ? $freq{$u}[WHERE] : undef;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( uniqueIndex( 2, 1, 1, 1, 1), 0, "Unique index first");
    is( uniqueIndex( 1, 2, 1, 1, 1), 1, "Unique index second");
    is( uniqueIndex( 1, 1, 1, 2, 1), 3, "Unique index penultimate");
    is( uniqueIndex( 1, 1, 1, 1, 2), 4, "Unique index last");
    is( uniqueIndex( 1, 1, 1, 1, 1), undef, "Unique index none");

    is( task(  "ab",   "bc",   "cd",   "zy"),   "zy", "Example 1");
    is( task(         "cba",  "fed",  "azy"),  "azy", "Example 2");
    is( task( "pop",  "ada",  "beb",  "cfc"),  "pop", "Example 3");
    is( task("aaaa", "zzzz", "mmmm", "aaba"), "aaba", "Example 4");
    is( task("aceg", "bdfh", "cegi", "azbz"), "azbz", "Example 5");

    done_testing;
}
