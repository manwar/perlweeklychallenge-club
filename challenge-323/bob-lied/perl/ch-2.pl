#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 323 Task 2 Tax Amount
#=============================================================================
# You are given an income amount and tax brackets.
# Write a script to calculate the total tax amount.
# Example 1
#   Input: $income = 10, @tax = ([3, 50], [7, 10], [12,25])
#   Output: 2.65
#       1st tax bracket upto  3, tax is 50%.
#       2nd tax bracket upto  7, tax is 10%.
#       3rd tax bracket upto 12, tax is 25%.
#       Total Tax => (3 * 50/100) + (4 * 10/100) + (3 * 25/100)
#                 => 1.50 + 0.40 + 0.75
#                 => 2.65
# Example 2
#   Input: $income = 2, @tax = ([1, 0], [4, 25], [5,50])
#   Output: 0.25
#       Total Tax => (1 * 0/100) + (1 * 25/100)
# Example 3
#   Input: $income = 0, @tax = ([2, 50])
#   Output: 0
#=============================================================================

use v5.40;
use List::AllUtils qw/min pairs/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

my $INCOME = shift;
say taxAmount($INCOME, pairs @ARGV);

#=============================================================================
sub taxAmount($income, @tax)
{
    my $tax = 0;

    # Sort brackets by threshold amount.
    @tax = sort { $a->[0] <=> $b->[0] } @tax;

    # Find overlapping ranges between income and bracket.
    my $bracketMin = 0;
    foreach ( @tax )
    {
        my $bracketMax = $_->[0];
        my $rate = $_->[1] / 100.0;

        if ( $income > $bracketMin )
        {
            my $amount = min($income, $bracketMax) - $bracketMin;
            $tax += $amount * $rate;
        }
        $bracketMin = $bracketMax;
    }
    return $tax;
}

sub runTest
{
    use Test2::V0;

    is( taxAmount(10, ([3, 50], [7, 10], [12,25])), 2.65, "Example 1");
    is( taxAmount( 2, ([1,  0], [4, 25], [ 5,50])), 0.25, "Example 2");
    is( taxAmount( 0, ([2, 50])                  ), 0.00, "Example 3");

    is( taxAmount(100_000, ([ 23_850, 10],
                            [ 96_950, 12],
                            [206_700, 22],
                            [394_600, 24],
                            [501_050, 32],
                            [751_600, 35],
                            [10_000_000_000, 37]) ),
                    11_828, "US 2025 Married filing jointly");

    is( taxAmount(100_000, ([ 11_925, 10],
                            [ 48_475, 12],
                            [103_350, 22],
                            [197_300, 24],
                            [250_525, 32],
                            [626_350, 35],
                            [10_000_000_000, 37]) ),
                    16_914, "US 2025 Single");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
