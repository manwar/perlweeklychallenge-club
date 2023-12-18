#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 248 Task 1 Shortest Distance
#=============================================================================
# You are given a string and a character in the given string.
# Write a script to return an array of integers of size same as length of
# the given string such that:
# distance[i] is the distance from index i to the closest occurence of
# the given character in the given string.
# The distance between two indices i and j is abs(i - j).
# Example 1 Input: $str = "loveleetcode", $char = "e"
#           Output: (3,2,1,0,1,0,0,1,2,2,1,0)
#   The character 'e' appears at indices 3, 5, 6, and 11 (0-indexed).
#   The closest occurrence of 'e' for index 0 is at index 3,
#   so the distance is abs(0 - 3) = 3.
#   The closest occurrence of 'e' for index 1 is at index 3,
#   so the distance is abs(1 - 3) = 2.
#   For index 4, there is a tie between the 'e' at index 3 and 'e' at index 5,
#   but the distance is still the same: abs(4 - 3) == abs(4 - 5) = 1.
#   The closest occurrence of 'e' for index 8 is at index 6,
#   so the distance is abs(8 - 6) = 2.
# Example 2 Input: $str = "aaab", $char = "b"
#           Output: (3,2,1,0)
#=============================================================================

use v5.38;

use builtin qw/true false ceil floor/; no warnings "experimental::builtin";

use List::Util qw/min/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(",", shortest(@ARGV)->@*), ")";

sub shortest($str, $char)
{
    my @dist;
    my @s = split //, $str; # str as vector of characters

    # List of indexes where char appears
    my @cloc = grep { $s[$_] eq $char } 0 .. $#s;

    # Potentially a lot of useless array operations, math
    # and comparisons if char appears a lot.
    for my $i ( 0 .. $#s )  # For each letter in str
    {
        #               List of location differences
        #               vvvvvvvvvvvvvvvvvvvvvvvvvvvv
        push @dist, min map { abs($_ - $i) } @cloc;
    }
    return \@dist;
}

# Only two location differences really matter: the next one
# ahead or the last one behind.  Alternate implementation
# looks only for those two.  Potentially a lot of string
# scanning if there are very few occurences of char in a
# long string.
sub sd2($str, $char)
{
    my @dist;
    for my $i ( 0 .. length($str)-1 )
    {
        my $ahead  =  index($str, "$char", $i);
        my $behind = rindex($str, "$char", $i);

        if ( $ahead < 0 && $behind < 0 )
        {
            push @dist, undef;
        }
        else
        {
            $behind = $ahead  if $behind == -1;
            $ahead  = $behind if $ahead  == -1;
            push @dist, min abs($i - $behind), abs($ahead - $i);
        }
    }
    return \@dist;
}

# We don't really need to calculate the differences for each
# letter.  The distance counts down until we see the first occurence,
# then up until half way to the next occurrence, then down again.
# Given the locations of the character, we can generate the sequences.
sub sd3($str, $char)
{
    return [ (undef) x length($str) ] if index($str, $char) < 0;
    my @s = split //, $str; # str as vector of characters

    # List of indexes where char appears
    my @cloc = grep { $s[$_] eq $char } 0 .. $#s;

    my @dist;
    my $loc = shift @cloc;
    push @dist, reverse 0 .. $loc;
    while ( defined(my $next = shift @cloc) )
    {
        my $diff = $next - $loc -1;
        push @dist, (1 .. ceil($diff/2)), reverse( 0 .. floor($diff/2));
        $loc = $next;
    }
    if ( $loc < $#s )
    {
        push @dist, 1 .. ($#s - $loc);
    }
    return \@dist;
}

sub runTest
{
    use Test2::V0;

    is( shortest("loveleetcode", 'e'), [3,2,1,0,1,0,0,1,2,2,1,0], "Example 1");
    is( shortest("aaab", 'b'), [3,2,1,0], "Example 2");

    is( shortest("ab", 'x'), [undef, undef], "no x in str");
    is( shortest("", 'x'), [], "empty string");

    is( sd2("loveleetcode", 'e'), [3,2,1,0,1,0,0,1,2,2,1,0], "sd2 Example 1");
    is( sd2("aaab", 'b'), [3,2,1,0], "sd2 Example 2");

    is( sd2("ab", 'x'), [undef, undef], "sd2 no x in str");
    is( sd2("", 'x'), [], "sd2 empty string");

    is( sd3("loveleetcode", 'e'), [3,2,1,0,1,0,0,1,2,2,1,0], "sd3 Example 1");
    is( sd3("aaab", 'b'), [3,2,1,0], "sd3 Example 2");

    is( sd3("ab", 'x'), [undef, undef], "sd3 no x in str");
    is( sd3("", 'x'), [], "sd3 empty string");

    done_testing;
}
