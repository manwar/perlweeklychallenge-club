#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Perl Weekly Challenge Week 194, Task 2: Frequency Equalizer
#=============================================================================
# Copyright (c) 2022, Bob Lied
#=============================================================================
# You are given a string made of alphabetic characters only, a-z.
# Write a script to determine whether removing only one character can make the
# frequency of the remaining characters the same.
#
# Example 1: Input: $s = 'abbc' Output: 1
# removing one 'b' will give us 'abc' where each letter frequency is the same.
# 
# Example 2: Input: $s = 'xyzyyxz' Output: 1
# since removing 'y' will give us 'xzyyxz'.
#
# Example 3: Input: $s = 'xzxz' Output: 0
# since removing any one letter would not give us string with same frequency
#=============================================================================

use v5.36;

use List::Util qw/all/;
use List::MoreUtils qw/frequency/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say canEqualize($_) for @ARGV;

sub canEqualize($str)
{
    my $strlen = length($str);

    if    ( $strlen == 0 ) { return 0; }
    elsif ( $strlen == 1 ) { return 1; }
    elsif ( $strlen == 2 ) { return 1; }

    my %freq = List::MoreUtils::frequency( split(//, $str) );
    my @byFrequency = sort { $freq{$b} <=> $freq{$a} } keys %freq;

    # If there's only one letter
    return 1 if @byFrequency == 1;

    # Can only be equalized if the most frequent letter occurs
    # once more than the rest, and all the rest are the same

    #my $isPlusOne = ( $freq{$byFrequency[0]} == $freq{$byFrequency[1]} + 1 );
    #my @slice = @byFrequency[2 .. $#byFrequency];
    #my $isSame = List::Util::all { $freq{$_} == $freq{$byFrequency[1]} } @slice;
    #return $isPlusOne && $isSame;
    
    my $can = ( $freq{$byFrequency[0]} == $freq{$byFrequency[1]} + 1 )
           && List::Util::all { $freq{$_} == $freq{$byFrequency[1]} }
                               @byFrequency[2 .. $#byFrequency];
    return $can ? 1 : 0; # We want the numeric value, not undef or ''
}

sub runTest
{
    use Test2::V0;

    is( canEqualize(""),        0, "EMPTY");
    is( canEqualize("a"),       1, "a");
    is( canEqualize("ab"),      1, "ab");
    is( canEqualize("bb"),      1, "bb");
    is( canEqualize("abbc"),    1, "abbc");
    is( canEqualize("ffff"),    1, "ffff");
    is( canEqualize("xyzyyxz"), 1, "xyzyyxz");
    is( canEqualize("xzxz"),    0, "xzxz");
    is( canEqualize("axxxz"),   0, "axxxz");

    done_testing();
}

