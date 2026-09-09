#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 390 Task 1  Decode String
#=============================================================================
# You are given an encoded string.  Write a script to return the decoded
# string of the given encoded string.  The encoding rule is: K[encoded_string],
# where the encoded_string inside the square brackets is repeated exactly
# K > 0 times.
# Example 1 Input: $str = "2[3[a]]"
#           Output: "aaaaaa"
# Example 2 Input: $str = "10[a]"
#           Output: "aaaaaaaaaa"
# Example 3 Input: $str = "a2[b]c3[d]e"
#           Output: "abbcddde"
# Example 4 Input: $str = "2[a2[b]c]"
#           Output: "abbcabbc"
# Example 5 Input: $str = "1[a]2[b3[c]]"
#           Output: "abcccbccc" 
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

say task($_) for @ARGV;

#=============================================================================
sub task($str)
{
    while ( $str =~ s/ (\d+) \[ ( [^[\]]+ ) \] /$2 x $1/gxe ) { }
    return $str;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(      "2[3[a]]"), "aaaaaa",     "Example 1)");
    is( task(        "10[a]"), "aaaaaaaaaa", "Example 2)");
    is( task(  "a2[b]c3[d]e"), "abbcddde",   "Example 3)");
    is( task(    "2[a2[b]c]"), "abbcabbc",   "Example 4)");
    is( task( "1[a]2[b3[c]]"), "abcccbccc",  "Example 5)");

    done_testing;
}
