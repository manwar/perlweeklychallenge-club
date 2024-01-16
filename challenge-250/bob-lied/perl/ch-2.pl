#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-2.pl Perl Weekly Challenge 250 Task 2 Alphanumeric String Value
#=============================================================================
# You are given an array of alphanumeric strings.
# Write a script to return the maximum value of alphanumeric string in
# the given array.  The value of alphanumeric string can be defined as
# a) The numeric representation of the string in base 10 if it is made
# up of digits only.  b) otherwise the length of the string
# Example 1 Input: @alphanumstr = ("perl", "2", "000", "python", "r4ku")
#           Output: 6
# Example 2 Input: @alphanumstr = ("001", "1", "000", "0001")
#           Output: 1
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say alnumstr(@ARGV);

sub alnumstr(@str)
{
    use List::Util qw/max/;
    return max map { $_ =~ m/\A\d+\Z/a ? 0+$_ : length($_) } @str;
}

sub runTest
{
    use Test2::V0;

    is( alnumstr("perl", "2", "000", "python", "r4ku"), 6, "Example 1");
    is( alnumstr( "001", "1", "000", "0001"          ), 1, "Example 1");

    is( alnumstr( "017", "016"), 17, "Octal?");

    is( alnumstr( "03", "02", "0x1"), 3, "Hex");

    done_testing;
}
