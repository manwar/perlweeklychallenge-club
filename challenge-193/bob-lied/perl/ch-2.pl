#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 193 Task 2 Odd String
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of strings of same length, @s.
# Write a script to find the odd string in the given list. Use positional
# value of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.
# Find the difference array for each string as shown in the example.
# Then pick the odd one out.
#
# Example 1: Input: @s = ("adc", "wzy", "abc") Output: "abc"
#   Difference array for "adc" => [ d - a, c - d ]
#                              => [ 3 - 0, 2 - 3 ]     => [ 3, -1 ]
#   Difference array for "wzy" => [ z - w, y - z ]
#                              => [ 25 - 22, 24 - 25 ] => [ 3, -1 ]
#   Difference array for "abc" => [ b - a, c - b ]
#                              => [ 1 - 0, 2 - 1 ]     => [ 1,  1 ]
#   The difference array for "abc" is the odd one.
# 
# Example 2: Input: @s = ("aaa", "bob", "ccc", "ddd") Output: "bob"
#   Difference array for "aaa" => [ a - a, a - a ]
#                              => [ 0 - 0, 0 - 0 ] => [  0,   0 ]
#   Difference array for "bob" => [ o - b, b - o ]
#                            => [ 14 - 1, 1 - 14 ] => [ 13, -13 ]
#   Difference array for "ccc" => [ c - c, c - c ]
#                            => [ 2 - 2, 2 - 2 ]   => [  0,   0 ]
#   Difference array for "ddd" => [ d - d, d - d ]
#                            => [ 3 - 3, 3 - 3 ]   => [  0,   0 ]
#   The difference array for "bob" is the odd one.
#=============================================================================

use v5.36;

use List::Util qw/all min/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say oddString(@ARGV);

sub oddString(@list)
{
    if ( @list < 3 )
    {
        warn "Should have at least three words";
        return "";
    }

    my $len = length($list[0]); # All assumed to be same length
    if ( ! all { length($_) == $len } @list ) 
    {
        # But go on, we can work up to a point
        $len = min map { length($_) } @list;
        warn "Not all strings same length, using length=$len";
    }

    # Convert each word into an array of numeric values We could use
    # ord(_)-ord('a') to match the spec exactly, but it cancels out
    # when we do the subtractions. ord(_) is enough.
    #
    # The outer map is forming an array of array references.
    # The inner map is doing the conversion from letters to numbers.
    #
    # Use of $_ is a bit subtle here.  At the right end, it refers
    # to the string in the @list array; in the ord in the middle
    # it refers to one character from the split operation.
    my @nlist = map { [ map { ord($_) } split '', $_ ] } @list;

    # Instead of computing the difference arrays and comparing them,
    # compare the differences at position i of each word.  We can
    # stop as soon as we see any unique value.
    for ( my $i = 1 ; $i < $len ; $i++ ) # Note: starts at 1, not 0
    {
        my $uniq = uniqIndex( map { $_->[$i] - $_->[$i-1] } @nlist );
        return $list[$uniq] if $uniq != -1;
    }
    return "";  # They're all the same, no unique value
}

# Find the position of a unique value, assuming the list
# is at least 3 long and there exists only one unique value
sub uniqIndex(@list)
{
    use List::MoreUtils qw/first_index/;

    if ( $list[0] != $list[1] )
    {
        # One of the first two numbers is the unique one
        return ( $list[0] == $list[2] ) ? 1 : 0;
    }
    return first_index { $_ != $list[0] } @list;
}

sub runTest
{
    use Test2::V0;

    is( oddString("adc", "wzy", "abc"),        "abc", "Example 1");
    is( oddString("aaa", "bob", "ccc", "ddd"), "bob", "Example 2");
    is( oddString("bob", "bob", "bob"),           "", "No odd one");
    is( oddString("abcd", "mnop", "stuw"),    "stuw", "Different at end");
    is( oddString("abcd", "mnqp", "stuv"),    "mnqp", "Different in middle");
    is( oddString("abcd", "aceg", "adgj"),    "abcd", "Not unique diffs, chooses first");
    is( oddString("abce", "mnop", "stuvwxyz"),"abce", "Different lengths accidentally works");
    is( oddString("abcd", "mnop", "stuxw"),  "stuxw", "Different lengths works up to a point");
    is( oddString("abcde", "mnop", "stuv"),       "", "Different lengths breaks");
    is( oddString("foo", "bar"),                  "", "Not enough words");
    is( oddString("abcd", "mñop", "stuw"),    "mñop", "En español");

    done_testing;
}
