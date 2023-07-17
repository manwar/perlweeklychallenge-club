#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Travel Expenditure 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given two list, @costs and @days.
# The list @costs contains the cost of three different types of travel cards
# you can buy.  For example @costs = (5, 30, 90)
# 
# Index 0 element represent the cost of  1 day  travel card.
# Index 1 element represent the cost of  7 days travel card.
# Index 2 element represent the cost of 30 days travel card.
#
# The list @days contains the day number you want to travel in the year.
# For example: @days = (1, 3, 4, 5, 6)
# 
# The above example means you want to travel on day 1, day 3, day 4, day 5
# and day 6 of the year.
#
# Write a script to find the minimum travel cost.
#
# Example 1: Input: @costs = (2, 7, 25)
#                   @days  = (1, 5, 6, 7, 9, 15)
#       Output: 11
#   On day 1, we buy a one day pass for 2 which would cover the day 1.
#   On day 5, we buy seven days pass for 7 which would cover days 5 - 9.
#   On day 15, we buy a one day pass for 2 which would cover the day 15.
#   So the total cost is 2 + 7 + 2 => 11.
#
# Example 2: Input: @costs = (2, 7, 25)
#                   @days  = (1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31)
#       Output: 20
#   On day 1, we buy a seven days pass for 7 which would cover days 1 - 7.
#   On day 10, we buy a seven days pass for 7 which would cover days 10 - 14.
#   On day 20, we buy a one day pass for 2 which would cover day 20.
#   On day 30, we buy a one day pass for 2 which would cover day 30.
#   On day 31, we buy a one day pass for 2 which would cover day 31.
#   So the total cost is 7 + 7 + 2 + 2 + 2 => 20.
#=============================================================================

use v5.36;

use List::Util qw/min max/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

use constant { _1_DAY_PASS => 0, _7_DAY_PASS => 1, _30_DAY_PASS => 2 };

my $MinCost;

sub _travel($pass, $days, $costSoFar, $passesUsed, $indent)
{
    return if @$days == 0;
    return if $costSoFar >= $MinCost;


    for my $passLength ( keys %{$pass} )
    {
        my $remainingDays = [ grep { $_ >= $days->[0] + $passLength } @$days ];

        say "${indent}TRY pass=$passLength sofar=$costSoFar days=[$days->@*] --> [$remainingDays->@*]" if $Verbose;

        if ( scalar(@$remainingDays) == 0 )
        {
            # Total coverage achieved.
            my $total = $costSoFar + $pass->{$passLength};
            print "${indent}FINISH cost=$total " if $Verbose;
            if ( $total < $MinCost )
            {
                $MinCost = $total;
                say "${indent}BETTER Min=$MinCost seq=[@$passesUsed $passLength]" if $Verbose;
            }
        }
        else
        {
            _travel($pass, $remainingDays, $costSoFar + $pass->{$passLength}, [ $passesUsed->@*, $passLength ], "| $indent");
        }
    }
}

sub travel
{
    my %args = @_;
    my $days = [ sort { $a <=> $b } $args{days}->@* ];

    my %pass = ( 1 => $args{costs}->[ _1_DAY_PASS],
                 7 => $args{costs}->[ _7_DAY_PASS],
                30 => $args{costs}->[_30_DAY_PASS] );

    # Start by assuming maximum possible cost.
    $MinCost = max( values %pass ) * scalar(@$days);

    _travel( \%pass, $days, 0, [], "");

    return $MinCost;
}


sub runTest
{
    use Test2::V0;

    is( travel( costs => [2, 7, 25],
                days  => [1, 5, 6, 7, 9, 15] ),
                    11, "Example 1");
    is( travel( costs => [2, 7, 25],
                days  => [1, 2, 3, 5, 7, 10, 11, 12, 13, 14, 20, 30, 31] ),
                    20, "Example 2");

    is( travel( costs => [2, 7, 25],
                days  => [1 .. 30] ),
                    25, "One month" );

    is( travel( costs => [2, 7, 25],
                days  => [1 .. 30, 101 .. 130] ),
                    50, "Two months" );

    is( travel( costs => [2, 7, 25],
                days  => [1 .. 30, 101 .. 130, 200] ),
                    52, "Two months and a day" );

    done_testing;
}
