#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 373 Task 1  Equal List
#=============================================================================
# You are given two arrays of strings.  Write a script to return true if
# the two given array represent the same strings otherwise false.
#
# Example 1 Input: @arr1 = ("a", "bc") @arr2 = ("ab", "c")
#           Output: true
#   Array 1: "a" + "bc" = "abc"     Array 2: "ab" + "c" = "abc"

# Example 2 Input: @arr1 = ("a", "b", "c") @arr2 = ("a", "bc")
#           Output: true
# Example 3 Input: @arr1 = ("a", "bc") @arr2 = ("a", "c", "b")
#           Output: false
# Example 4 Input: @arr1 = ("ab", "c", "") @arr2 = ("", "a", "bc")
#           Output: true
# Example 5 Input: @arr1 = ("p", "e", "r", "l") @arr2 = ("perl")
#           Output: true
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

die "Usage: $0 'a1 a2 ...' 'b1 b2 ..." unless @ARGV == 2;
say equalList([ split(" ", shift) ], [ split(" ", shift) ]) ? "true" : "false";

#=============================================================================
sub equalList($arr1, $arr2)
{
    return join("", $arr1->@*) eq join("", $arr2->@*);
}

sub runTest
{
    use Test2::V0;

    is( equalList( ["a", "bc"], ["ab", "c"]),         true, "Example 1");
    is( equalList( ["a", "b", "c"], ["a", "bc"]),     true, "Example 2");
    is( equalList( ["a", "bc"], ["a", "c", "b"]),    false, "Example 3");
    is( equalList( ["ab", "c", ""], ["", "a", "bc"]), true, "Example 4");
    is( equalList( ["p", "e", "r", "l"], ["perl"]),   true, "Example 5");

    done_testing;
}
