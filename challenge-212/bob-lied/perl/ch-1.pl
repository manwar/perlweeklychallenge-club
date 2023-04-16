#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 212 Task 1 Jumping Letters 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a word having alphabetic characters only, and a list of
# positive integers of the same length.
# Write a script to print the new word generated after jumping forward each
# letter in the given word by the integer in the list. The given list would have
# exactly the number as the total alphabets in the given word.
# Example 1 Input: $word = 'Perl' and @jump = (2,22,19,9)
#           Output: Raku
#   'P' jumps 2 place forward and becomes 'R'.
#   'e' jumps 22 place forward and becomes 'a'.
#       (jump is cyclic i.e. after 'z' you go back to 'a')
#   'r' jumps 19 place forward and becomes 'k'.
#   'l' jumps 9 place forward and becomes 'u'.
# Example 2 Input: $word = 'Raku' and @jump = (24,4,7,17)
#           Output: 'Perl'
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub jumpLetter($c, $n)
{
    my $v = ord($c);
    my $lc_a = ord('a');
    my $uc_A = ord('A');
    if ( $lc_a <= $v <= ord('z') )
    {
        return chr($lc_a+(($v - $lc_a) + $n) % 26);
    }
    elsif ( $uc_A <= $v <= ord('Z') )
    {
        return chr($uc_A+(($v - $uc_A) + $n) % 26);
    }
    else
    {
        return $c;
    }
}

sub jumpWord($word, $jumps)
{
    # return join "", map { jumpLetter(substr($word, $_, 1), $jumps->[$_]) } 0 .. $jumps->$#*;
    substr($word, $_, 1, jumpLetter(substr($word, $_, 1), $jumps->[$_]) ) for 0 .. $jumps->$#*;
    return $word;
}

sub runTest
{
    use Test2::V0;

    is( jumpWord("Perl", [2,22,19,9]), "Raku", "Example 1");
    is( jumpWord("Raku", [24,4,7,17]), "Perl", "Example 2");

    done_testing;
}

