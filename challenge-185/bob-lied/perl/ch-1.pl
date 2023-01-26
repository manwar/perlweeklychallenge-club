#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 185 Task 1 Mac Address
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given MAC address in the form i.e. hhhh.hhhh.hhhh.
# Write a script to convert the address in the form hh:hh:hh:hh:hh:hh.
# Example 1 Input:  1ac2.34f0.b1c2 Output: 1a:c2:34:f0:b1:c2
# Example 2 Input:  abc1.20f1.345a Output: ab:c1:20:f1:34:5a
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

for ( @ARGV )
{
    if ( ! m/[[:xdigit:]]{4}\.[[:xdigit:]]{4}\.[[:xdigit:]]{4}/ )
    {
        warn "Format error in '$_', use xxxx.yyyy.zzzz where x, y and z are hex digits";
        next;
    }
    say macAddr($_);
}

sub macAddr($m)
{
    # Match pairs of hex digits and return all of them as an array,
    # Map any uppercase characters to lowercase
    # then join the pairs with a colon
    return join ":", map { lc } ($m =~ m/([[:xdigit:]]{2})/g) ;
}

sub runTest
{
    use Test2::V0;

    is( macAddr("1ac2.34f0.b1c2"), "1a:c2:34:f0:b1:c2", "Example 1");
    is( macAddr("abc1.20f1.345a"), "ab:c1:20:f1:34:5a", "Example 2");
    is( macAddr("ABC1.20F1.345A"), "ab:c1:20:f1:34:5a", "Uppercase");

    done_testing;
}

