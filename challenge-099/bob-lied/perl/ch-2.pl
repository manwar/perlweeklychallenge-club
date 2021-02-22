#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
#  Perl Weekly Challeng 99, TASK #2 › Unique Subsequence
# You are given two strings $S and $T.
# Write a script to find out count of different unique subsequences matching
# $T without changing the position of characters.
# Example 1: Input: $S = "littleit', $T = 'lit'
# Output: 5
# 1: [lit] tleit
# 2: [li] t [t] leit
# 3: [li] ttlei [t]
# 4: litt [l] e [it]
# 5: [l] ittle [it]
#
# Example 2: Input: $S = "london', $T = 'lon'
# Output: 3
# 1: [lon] don
# 2: [lo] ndo [n]
# 3: [l] ond [on]
# 
#=============================================================================

use strict;
use warnings;
use 5.020;
use experimental qw/ signatures /;

use Getopt::Long;
my $doTest;
my $verbose;
GetOptions("test" => \$doTest, "verbose" => \$verbose);
exit(!runTest()) if $doTest;

sub Usage { "$0 'string' 'str'" }

my $S = shift;
my $T = shift;
die Usage() unless $S;
die Usage() unless $T;

say uniqSubSeq($S, $T);

sub uniqSubSeq($s, $t)
{
    return findNextLetter($s, $t, 0);
}

sub findNextLetter($s, $t, $count)
{
    return $count unless $s && $t;
    my $c = substr($t, 0, 1);
    my $isLastChar = ( length($t) == 1 );
    
    my $p = index($s, $c);
    say "ENTER: s=[$s] t=[$t] c=[$c] p=[$p] count=[$count]" if $verbose;
    while ( $p != -1 )
    {
        if ( $isLastChar )
        {
            $count++;
        }
        else
        {
            $count = findNextLetter( substr($s, $p+1), substr($t, 1), $count );
        }
        $p = index($s, $c, $p+1);
        say " LOOP: s=[$s] t=[$t] c=[$c] p=[$p] count=[$count]" if $verbose;
    }
    return $count;
}

sub runTest
{
    use Test::More;

    is( uniqSubSeq("",         "a"),       0);
    is( uniqSubSeq("a",         ""),       0);
    is( uniqSubSeq("a",        "a"),       1);
    is( uniqSubSeq("a",        "b"),       0);
    is( uniqSubSeq("aa",       "a"),       2);
    is( uniqSubSeq("littleit", "lit"),     5);
    is( uniqSubSeq("london",   "lon"),     3);

    done_testing;
}
