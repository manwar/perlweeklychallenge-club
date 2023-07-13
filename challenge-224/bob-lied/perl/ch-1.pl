#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 224 Task 1 Special Notes 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given two strings, $source and $target.
# Write a script to find out if using the characters (only once) from source,
# a target string can be created.
# Example 1 Input: $source = "abc" $target = "xyz"
#           Output: false

# Example 2 Input: $source = "scriptinglanguage" $target = "perl"
#           Output: true

# Example 3 Input: $source = "aabbcc" $target = "abc"
#           Output: true
#=============================================================================

use v5.36;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub usage() { "Usage: $0 source target" }

do { say STDERR usage(); exit 1 } unless @ARGV == 2;

say specialNotes(@ARGV);

sub specialNotes($source, $target)
{
    for my $char ( split(//, $target) )
    {
        if ( my $atPosition = index($source, $char) < 0 )
        {
            return "false";
        }
        else
        {
            substr($source, $atPosition, 1) = "";
        }
    }
    return "true";
}

sub runTest
{
    use Test2::V0;

    is( specialNotes("abc", "xyz"),                "false", "Example 1");
    is( specialNotes("scriptinhlanguage", "perl"),  "true", "Example 2");
    is( specialNotes("aabbcc", "abc"),              "true", "Example 3");

    done_testing;
}
