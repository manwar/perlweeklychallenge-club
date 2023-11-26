#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 241 Task 1 Arithmetic Triplets
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array (3 or more members) of integers in increasing
# order and a positive integer.  Write a script to find out the number
# of unique Arithmetic Triplets satisfying the following rules:
# a) i < j < k
# b) nums[j] - nums[i] == diff
# c) nums[k] - nums[j] == diff
# Example 1 Input: @nums = (0, 1, 4, 6, 7, 10) $diff = 3
#           Output: 2
#   Index (1, 2, 4) is an arithmetic triplet
#   because both  7 - 4 == 3 and 4 - 1 == 3.
#   Index (2, 4, 5) is an arithmetic triplet
#   because both 10 - 7 == 3 and 7 - 4 == 3.
# Example 2 Input: @nums = (4, 5, 6, 7, 8, 9) $diff = 2
#           Output: 2
#   (0, 2, 4) is an arithmetic triplet with difference 2
#   (1, 3, 5) is an arithmetic triplet with difference 2
#=============================================================================

use v5.38;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

my $Diff;

GetOptions("diff:i" => \$Diff, "test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

die "Usage: $0 -d DIFF m n o ..." unless defined $Diff && @ARGV > 0;

say triplet($Diff, @ARGV);

sub triplet($diff, @nums)
{
    my $count = 0;
    my @show;
    # for ( my $i = 0 ; $i <= $#nums-2; $i++ )
    while ( defined(my $i = shift @nums ) )
    {
        for ( my $j = 0; $j <= $#nums-1; $j++ )
        {
            my $dj = $nums[$j] - $i;

            # Input is sorted, so stop once the difference is too big.
            last if $dj > $diff;
            next unless $dj == $diff;

            for ( my $k = $j+1; $k <= $#nums ; $k++ )
            {
                my $dk = $nums[$k] - $nums[$j];
                last if $dk > $diff;
                if ( $dk == $diff )
                {
                    $count++;
                    push @show, [ $i, $j, $k ] if $Verbose;
                }
            }
        }
    }
    if ( $Verbose )
    {
        for my $triplet ( @show )
        {
            say "\@nums[$triplet->@*] = ( @nums[$triplet->@*] )";
        }
    }
    return $count;
}

sub runTest
{
    use Test2::V0;

    is( triplet(3, 0,1,4,6,7,10), 2, "Example 1");
    is( triplet(2, 4,5,6,7,8,9 ), 2, "Example 2");

    done_testing;
}
