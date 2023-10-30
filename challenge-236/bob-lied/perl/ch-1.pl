#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 236 Task 1 Exact Change  
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are asked to sell juice each costs $5. You are given an array of bills.
# You can only sell ONE juice to each customer but make sure you return exact
# change back. You only have $5, $10 and $20 notes. You do not have any
# change in hand at first.
#
# Write a script to find out if it is possible to sell to each customers
# with correct change.
#
# Example 1 Input: @bills = (5, 5, 5, 10, 20)
#           Output: true
#   From the first 3 customers, we collect three $5 bills in order.
#   From the fourth customer, we collect a $10 bill and give back a $5.
#   From the fifth customer, we give a $10 bill and a $5 bill.
#   Since all customers got correct change, we output true.
#
# Example 2 Input: @bills = (5, 5, 10, 10, 20)
#           Output: false
#   From the first two customers in order, we collect two $5 bills.
#   For the next two customers in order, we collect a $10 bill and give
#   back a $5 bill.
#   For the last customer, we can not give the change of $15 back because
#   we only have two $10 bills.
#   Since not every customer received the correct change, the answer is false.
#
# Example 3 Input: @bills = (5, 5, 5, 20)
#           Output: true
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings 'experimental::builtin';

$" = ', '; # LIST_SEPARATOR, for printing an array in verbose tracing
use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;


GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say exactChange(@ARGV) ? "true" : "false";

sub exactChange(@bills)
{
use constant { FIVE => 0, TEN => 1, TWENTY => 2 };
    my @register = ( 0, 0, 0 );
    my $changeGiven = true;
    while ( (my $payment = shift @bills) && $changeGiven )
    {
        if ( $payment == 5 )
        {
            say "Got a 5, register=(@register)" if $Verbose;
            $register[FIVE]++;
        }
        elsif ( $payment == 10 )
        {
            say "Got a 10, register=(@register)" if $Verbose;
            if ( $register[FIVE] )
            {
                say "   Gave change 5" if $Verbose;
                $register[FIVE]--;
            }
            else
            {
                say "   NO 5, FAIL" if $Verbose;
                $changeGiven = false;
            }
            $register[TEN]++;
        }
        elsif ( $payment == 20 )
        {
            say "Got a 20, register=(@register)" if $Verbose;
            if ( $register[TEN] && $register[FIVE] )
            {
                say "   Give a 5 and a 10" if $Verbose;
                $register[TEN]--;
                $register[FIVE]--;
            }
            elsif ( $register[FIVE] >= 3 )
            {
                say "   Gave three 5s" if $Verbose;
                $register[FIVE] -= 3;
            }
            else
            {
                say "   No 15, FAIL" if $Verbose;
                $changeGiven = false
            }
            $register[TWENTY]++;
        }
        else
        {
            say "Got a fake bill" if $Verbose;
        }
    }
    say "DONE: register:(@register) customer=(@bills) change=$changeGiven" if $Verbose;
    return @bills == 0 && $changeGiven;
}

sub runTest
{
    use Test2::V0;
    no warnings 'experimental::builtin';

    is( exactChange(5,5,5,10,20),  true,  "Example 1");
    is( exactChange(5,5,10,10,20), false, "Example 2");
    is( exactChange(5,5,5,20),     true,  "Example 3");

    done_testing;
}
