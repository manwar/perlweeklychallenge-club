#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 179 Task 1 Ordinal Number Spelling
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a positive number, $n.
# Write a script to spell the ordinal number.
# Examples
#   11 => eleventh
#   62 => sixty-second
#   99 => ninety-ninth
#=============================================================================

use v5.36;

my @Ones = qw( zeroth first second  third  fourth
               fifth  sixth seventh eighth ninth
               tenth eleventh twelfth thirteenth fourteenth
               fifteenth sixteenth seventeenth eighteenth nineteenth );

my %Extra = ( 1 => "first", 2 => "second", 3 => "third", 5 => "fifth" );

my @Tens = qw( zero teen twenty thirty forty
               fifty sixty seventy eighty ninety );

my @BigName = qw(none thousand million billion trillion quatrillion quintillion
             sextillion septillion octillion nonillion decillion );

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub runTest
{
    use Test2::V0;

    is(0, 1, "FAIL");

    done_testing;
}

