#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 285 Task 2 Make Change
#=============================================================================
# Compute the number of ways to make change for given amount in cents.
# By using the coins e.g. Penny, Nickel, Dime, Quarter and Half-dollar,
# in how many distinct ways can the total value equal to the given amount?
# Order of coin selection does not matter.
# A penny (P) is equal to 1 cent.
# A nickel (N) is equal to 5 cents.
# A dime (D) is equal to 10 cents.
# A quarter (Q) is equal to 25 cents.
# A half-dollar (HD) is equal to 50 cents.
#
# Example 1 Input: $amount = 9
#           Output: 2
#   1: 9P
#   2: N + 4P
# Example 2 Input: $amount = 15
#           Output: 6
#   1: D + 5P
#   2: D + N
#   3: 3N
#   4: 2N + 5P
#   5: N + 10P
#   6: 15P
# Example 3 Input: $amount = 100
#           Output: 292
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

my %Coin = ( 50 => "H", 25 => "Q", 10 => "D", 5 => "N", 1 => "P" );
my @Value = sort { $b <=> $a } keys %Coin;

sub toStr($val, $count) { $count . $Coin{$val} }

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say makeChange($_) for @ARGV;

sub makeChange($amount)
{
    my @combination = _makeChange($amount, $Value[0]+1);
    if ( $Verbose) { my $i = 0; do { $i++; say "$i: $_" } for @combination }
    return scalar(@combination);
}

use Memoize;
memoize('_makeChange');

sub _makeChange($amount, $threshold, $in="")
{
    my @combo;
    for my $val ( @Value )
    {
        next if ( $val > $amount || $val >= $threshold );

        if ( $val == 1 )
        {
            push @combo, toStr($val, $amount);
            next;
        }

        for ( my $valCount = int($amount/$val); $valCount > 0 ; $valCount-- )
        {
            my $remain = $amount - $valCount * $val;
            if ( $Verbose ) { say "$in$amount try $valCount*$val, remain=$remain" };
            if ( $remain == 0 )
            {
                push @combo, toStr($val, $valCount);
            }
            else
            {
                for my $way ( _makeChange($remain, $val, "  $in") )
                {
                    push @combo, join("+", toStr($val, $valCount), $way);
                }
            }
        }
    }
    return @combo;
}

sub runTest
{
    use Test2::V0;

    is( makeChange(  9),   2, "Example 1");
    is( makeChange( 15),   6, "Example 2");
    is( makeChange(100), 292, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
