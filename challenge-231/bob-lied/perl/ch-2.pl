#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 231 Task 2 Senior Citizens
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of passenger details in the form “9999999999A1122”,
# where 9 denotes the phone number, A the sex, 1 the age and 2 the seat number.
# Write a script to return the count of all senior citizens (age >= 60).
# Example 1 Input: @list = ("7868190130M7522","5303914400F9211","9273338290F4010")
#           Ouput: 2
#   The age of the passengers in the given list are 75, 92 and 40.
#   So we have only 2 senior citizens.
# Example 2 Input: @list = ("1313579440F2036","2921522980M5644")
#           Ouput: 0
#   The ages are 20 and 56.   
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub seniorCitizen(@passenger)
{
    return scalar grep { $_ >= 60 } map { substr($_, 11, 2) } @passenger;
}

sub sc_pack(@passenger)
{
    return scalar grep {
        #my ($phone, $sex, $age, $seat) = unpack("A10 A1 A2 A2", $_);
        #$age >= 60;
        (unpack("A10 A1 A2 A2", $_))[2] >= 60
    } @passenger
}

sub runTest
{
    use Test2::V0;

    is( seniorCitizen( qw( 7868190130M7522 5303914400F9211 9273338290F4010) ), 2, "Example 1");
    is( seniorCitizen( qw( 1313579440F2036 2921522980M5644) ), 0, "Example 2");

    is( sc_pack( qw( 7868190130M7522 5303914400F9211 9273338290F4010) ), 2, "Example 1");
    is( sc_pack( qw( 1313579440F2036 2921522980M5644) ), 0, "Example 2");

    done_testing;
}
