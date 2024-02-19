#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-2.pl Perl Weekly Challenge 256 Task 2 Merge Strings
#=============================================================================
# You are given two strings, $str1 and $str2.
# Write a script to merge the given strings by adding in alternative order
# starting with the first string. If a string is longer than the other then
# append the remaining at the end.
# Example 1 Input: $str1 = "abcd", $str2 = "1234"
#           Output: "a1b2c3d4"
# Example 2 Input: $str1 = "abc", $str2 = "12345"
#           Output: "a1b2c345"
# Example 3 Input: $str1 = "abcde", $str2 = "123"
#           Output: "a1b2c3de"
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub mrgstr_mesh($str1, $str2)
{
    use List::MoreUtils qw/mesh/;
    my @s = split(//, $str1);
    my @t = split(//, $str2);
    return join("", grep { defined } mesh(@s, @t) );
}

sub mrgstr_comb($str1, $str2)
{
    return $str1 if $str2 eq "";
    return $str2 if $str1 eq "";

    # Make both strings the same length
    my $SPACE = "\007";
    my ($len1, $len2) = ( length($str1), length($str2) );
    if    ( $len2 > $len1 ) { $str1 .= ("$SPACE" x ($len2-$len1)) }
    elsif ( $len1 > $len2 ) { $str2 .= ("$SPACE" x ($len1-$len2)) }

    # Make space in s for the characters of str2
    my @s = map { $_ => "$SPACE" } split(//, $str1);

    # Replace odd indexes of s with characters from str2
    @s[ map { 2*$_+1 } 0..$#s/2 ] = ( split(//, $str2) );

    # Shrink s back to a string without extra space
    return join("", grep { $_ ne "$SPACE" } @s);
}

sub mrgstr($str1, $str2)
{
    my @s = split(//, $str1);
    my @t = split(//, $str2);
    my @m;

    while ( defined(my $one = shift @s) )
    {
        push @m, $one, (shift @t // '');
        last unless @t;
    }
    push @m, @s, @t; # s or t or both will be empty lists

    return join("", @m);
}

sub runTest
{
    use Test2::V0;

    is( mrgstr_mesh("abcd", "1234"), "a1b2c3d4", "Example 1 mesh");
    is( mrgstr_mesh("abc", "12345"), "a1b2c345", "Example 2 mesh");
    is( mrgstr_mesh("abcde", "123"), "a1b2c3de", "Example 3 mesh");
    is( mrgstr_mesh("", "123"), "123", "Empty one mesh");
    is( mrgstr_mesh("abc", ""), "abc", "Empty two mesh");
    is( mrgstr_mesh("", ""   ), "",    "Empty both mesh");

    is( mrgstr_comb("abcd", "1234"), "a1b2c3d4", "Example 1 comb");
    is( mrgstr_comb("abc", "12345"), "a1b2c345", "Example 2 comb");
    is( mrgstr_comb("abcde", "123"), "a1b2c3de", "Example 3 comb");
    is( mrgstr_comb("", "123"), "123", "Empty one comb");
    is( mrgstr_comb("abc", ""), "abc", "Empty two comb");
    is( mrgstr_comb("", ""   ), "",    "Empty both comb");

    is( mrgstr("abcd", "1234"), "a1b2c3d4", "Example 1");
    is( mrgstr("abc", "12345"), "a1b2c345", "Example 2");
    is( mrgstr("abcde", "123"), "a1b2c3de", "Example 3");
    is( mrgstr("", "123"), "123", "Empty one");
    is( mrgstr("abc", ""), "abc", "Empty two");
    is( mrgstr("", ""   ), "",    "Empty both");

    done_testing;
}
