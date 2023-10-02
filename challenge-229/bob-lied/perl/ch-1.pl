#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Task 1 Lexicographic Order
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of strings.
# Write a script to delete element which is not lexicographically sorted
# (forwards or backwards) and return the count of deletions.
# Example 1 Input: @str = ("abc", "bce", "cae")
#           Output: 1
# Example 2 Input: @str = ("yxz", "cba", "mon")
#           Output: 2
#=============================================================================

use v5.38;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# This version doesn't actually perform deletions, it just counts how
# many would be deleted, which satisfies the output requirement.
sub lexicographicOrderCount(@str)
{
    my $isSorted = @str;    # Assume all are sorted
    for my $word ( @str )
    {
        my $sorted = join("", sort { $a cmp $b} split("", $word) );
        $isSorted-- if $word eq $sorted || $word eq reverse($sorted);
    }
    return $isSorted;
}

# This version also provides a list with unsorted elements removed.
sub lexicographicOrder(@str)
{
    my $deleteCount = 0;
    my @keepList; # Instead of deleting, build new list of kept words
    for my $word ( @str )
    {
        my $sorted = join("", sort { $a cmp $b} split("", $word) );
        if ( $word eq $sorted || $word eq reverse($sorted) )
        {
            push @keepList, $word;
        }
        else
        {
            $deleteCount++;
        }
    }
    return ($deleteCount, \@keepList);
}

sub runTest
{
    use Test2::V0;

    is( lexicographicOrderCount("abc", "bce", "cae"), 1, "Example 1 count only");
    is( lexicographicOrderCount("yxz", "cba", "mon"), 2, "Example 2 count only");

    my ($count, $list);
    ($count, $list) = lexicographicOrder("abc", "bce", "cae");
    is ( $count, 1, "Example 1 count");
    is ( $list, ["abc", "bce"], "Example 1 list");

    ($count, $list) = lexicographicOrder("yxz", "cba", "mon");
    is ( $count, 2, "Example 2 count");
    is ( $list, ["cba"], "Example 2 list");

    done_testing;
}
