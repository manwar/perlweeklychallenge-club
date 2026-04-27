#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 370 Task 2  Scramble String
#=============================================================================
# You are given two strings A and B of the same length.
# Write a script to return true if string B is a scramble of string A
# otherwise return false.  String B is a scramble of string A if A can be
# transformed into B by a single (recursive) scramble operation.
# A scramble operation is:
#   - If the string consists of only one character, return the string.
#   - Divide the string X into two non-empty parts.
#   - Optionally, exchange the order of those parts.
#   - Optionally, scramble each of those parts.
#   - Concatenate the scrambled parts to return a single string.
#
# Example 1 Input: $str1 = "abc", $str2 = "acb"
#			Output: true
#   "abc" -> split: ["a", "bc"] -> split: ["a", ["b", "c"]] swap: ["a", ["c", "b"]]
#
# Example 2 Input: $str1 = "abcd", $str2 = "cdba"
#			Output: true
#   split: ["ab", "cd"] -> swap: ["cd", "ab"] ->
#   split: ["cd", ["a", "b"]] -> swap: ["cd", ["b", "a"]]
#
# Example 3 Input: $str1 = "hello", $str2 = "hiiii"
#			Output: false
#
# Example 4 Input: $str1 = "ateer", $str2 = "eater"
#			Output: true
#   split: ["ate", "er"] -> split: [["at", "e"], "er"] -> swap: [["e", "at"], "er"]
#
# Example 5 Input: $str1 = "abcd", $str2 = "bdac"
#			Output: false
#=============================================================================

use v5.42;


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

say isScramble(@ARGV) ? "true" : "false";

#=============================================================================
sub splits($str)
{
    [ map { [ substr($str, 0, $_), substr($str, $_) ] } ( 1 .. length($str)-1 ) ];
}

sub isScramble($str1, $str2, $depth = "")
{
    state %remember;
    %remember = () if $depth eq "";

    my $key = ":$str1:$str2:";
    if ( exists $remember{$key} )
    {
        $logger->debug("${depth}CACHED $key = ", ($remember{$key} ? "true":"false"));
        return $remember{$key}
    }

    my $len = length($str1);
    return ( $remember{$key} = false) if $len != length($str2);
    return ( $remember{$key} =  true) if $str1 eq $str2;

    for ( 1 .. $len-1 )
    {
        # $_ is the length of the left substring (head), $len-$_ is length of right (tail)
        my (  $head,   $tail) = ( substr($str1, 0, $_), substr($str1, $_) );
        my ($s2head, $s2tail) = ( substr($str2, 0, $_), substr($str2, $_) );

        my $s2front = substr($str2, 0, $len-$_);   # length of $tail, on left side
        my $s2back  = substr($str2, -$_);          # length of $head, on right side

        $logger->debug("${depth}Compare [$head/$tail] <> s2head/$s2tail] ($s2front/$s2back)");

        if ( "$tail$head" eq $str2 )
        {
            $logger->debug("${depth}FOUND $str2");
            return $remember{$key} = true;
        }
        elsif ( $head eq $s2head )
        {
            $logger->debug("${depth}HH, compare $tail <> $s2tail");
            return true if $remember{$key} = isScramble($tail, $s2tail, "  $depth");
        }
        elsif ( $head eq $s2back )
        {
            $logger->debug("${depth}HB, compare $tail <> s2front");
            return true if $remember{$key} = isScramble($tail, $s2front, "  $depth");
        }
        elsif ( $tail eq $s2tail )
        {
            $logger->debug("${depth}TT, compare $head <> s2head");
            return true if $remember{$key} = isScramble($head, $s2head, "  $depth");
        }
        elsif ( $tail eq $s2front )
        {
            $logger->debug("${depth}TF, compare $head <> s2back");
            return true if $remember{$key} = isScramble($head, $s2back, "  $depth");
        }
        else
        {
            $logger->debug("${depth}No pairs, recurse with $head<>$s2head and $tail<>$s2tail");
            return $remember{$key} = true if ( 
                   ( isScramble($head, $s2head, "  $depth")
                  && isScramble($tail, $s2tail, "  $depth") )
                || ( isScramble($head, $s2back, "  $depth")
                  && isScramble($tail, $s2front, "  $depth") ) );
        }
    }

    $logger->debug("${depth}NOT FOUND $key = false (caching)");
    return $remember{$key} = false;
}

sub runTest
{
    use Test2::V0;

    is( splits("1"), [], "Split one character");
    is( splits("xy"), [ ["x", "y"] ], "Split xy");
    is( splits("xyz"), [ ["x","yz"], ["xy","z"] ], "Split xyz");
    is( splits("wxyz"), [ ["w","xyz"], ["wx","yz"], ["wxy","z"] ], "Split wxyz");


    is( isScramble(    "x",     "x"),  true, "One character yes");
    is( isScramble(    "x",     "y"), false, "One character no");
    is( isScramble(  "abc",   "acb"),  true, "One letter swap 1");
    is( isScramble(  "abc",   "bac"),  true, "One letter swap 2");
    is( isScramble(  "abc",   "bca"),  true, "One letter swap 3");
    is( isScramble(  "abc",   "cab"),  true, "One letter swap 4");
    is( isScramble(  "abc",   "cba"),  true, "One letter swap 5");

    is( isScramble(  "abc",   "acb"),  true, "Example 1");
    is( isScramble( "abcd",  "cdba"),  true, "Example 2");
    is( isScramble("hello",  "hiii"), false, "Example 3");
    is( isScramble("ateer", "eater"),  true, "Example 4");
    is( isScramble( "abcd",  "bdac"), false, "Example 5");
    is( isScramble( "abcd",  "dbac"),  true, "Example 5+");

    done_testing;
    return;
}
