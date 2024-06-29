#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 275 Task 2 Replace Digits
#=============================================================================
# You are given an alphanumeric string, $str, where each character is
# either a letter or a digit.
# Write a script to replace each digit in the given string with the
# value of the previous letter plus (digit) places.
# Example 1 Input: $str = 'a1c1e1'
#           Ouput: 'abcdef'
#   shift('a', 1) => 'b' shift('c', 1) => 'd' shift('e', 1) => 'f'
# Example 2 Input: $str = 'a1b2c3d4'
#           Output: 'abbdcfdh'
#   shift('a', 1) => 'b' shift('b', 2) => 'd'
#   shift('c', 3) => 'f' shift('d', 4) => 'h'
# Example 3 Input: $str = 'b2b'
#           Output: 'bdb'
# Example 4 Input: $str = 'a16z'
#           Output: 'abgz'
#=============================================================================

use v5.40;


use Getopt::Long;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest);
exit(!runTest()) if $DoTest;

# Must not begin with a digit
say replaceDigits($_) for map { s/^[0-9]*//ir } @ARGV;

sub replaceDigits($str)
{
    my @s = split("", $str);
    my $letter = my $result = shift @s;

    while ( defined(my $next = shift @s) )
    {
        if ( $next =~ m/[^0-9]/i ) { $result .= ($letter = $next) }
        else { $result .= chr(ord($letter) + $next); }
    }
    return $result;
}


sub runTest
{
    use Test2::V0;

    is( replaceDigits("a1c1e1"  ), "abcdef"  , "Example 1");
    is( replaceDigits("a1b2c3d4"), "abbdcfdh", "Example 2");
    is( replaceDigits("b2b"     ), "bdb"     , "Example 3");
    is( replaceDigits("a16z"    ), "abgz"    , "Example 4");

    done_testing;
}
