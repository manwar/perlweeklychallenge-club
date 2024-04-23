#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-2.pl Perl Weekly Challenge 265 Task 2 Completing Word
#=============================================================================
# You are given a string, $str containing alphnumeric characters, and an
# array of strings (alphabetic characters only), @str.
# Write a script to find the shortest completing word.
# If none found return empty string.
#
# A completing word is a word that contains all the letters in the given
# string, ignoring space and number. If a letter appeared more than once in
# the given string then it must appear the same number or more in the word.
# Example 1 Input: $str = 'aBc 11c'
#                  @str = ('accbbb', 'abc', 'abbc')
#           Output: 'accbbb'
#   The given string contains following, ignoring case and number:
#   a 1 time, b 1 time, c 2 times
#   The only string in the given array that satisfies the condition is 'accbbb'.
# Example 2 Input: $str = 'Da2 abc'
#                  @str = ('abcm', 'baacd', 'abaadc')
#           Output: 'baacd'
#   The given string contains following, ignoring case and number:
#   a 2 times, b 1 time, c 1 time, d 1 time,
#   Two strings in the array satisfy the condition ('baacd' and 'abaadc')
#   but 'baacd' is shorter.
# Example 3 Input: $str = 'JB 007'
#                  @str = ('jj', 'bb', 'bjb')
#           Output: 'bjb'
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $str = shift;
say cw($str, @ARGV);

sub lfreq($str)
{
    use List::MoreUtils qw/frequency/;
    my %f = frequency( split(//, $str) );
    return \%f;
}

sub satisfies($need, $have)
{
    use List::Util qw/all/;
    all { ($have->{$_} // 0) >= $need->{$_} } keys %$need;
}

sub cw($str, @str)
{
    # $str = lc($str);
    # $str =~ s/[^a-z]//g;
    # my $need = lfreq($str);

    my $need = lfreq((my $s = lc($str)) =~ s/[^a-z]//gr);

    my @candidates = sort { length($a) <=> length($b) }
                        grep { satisfies($need, lfreq($_)) } @str;
    return ( @candidates ? $candidates[0] : '' );
}

sub runTest
{
    use Test2::V0;

    is( cw('aBc 11c', qw(accbbb abc abbc)  ), 'accbbb', "Example 1");
    is( cw('Da2 abc', qw(abcm baacd abaadc)), 'baacd' , "Example 2");
    is( cw('JB 007' , qw(jj bb bjb)        ), 'bjb'   , "Example 3");

    is( cw('perl'   , qw(python ruby java) ), '',     , "None work");

    done_testing;
}
