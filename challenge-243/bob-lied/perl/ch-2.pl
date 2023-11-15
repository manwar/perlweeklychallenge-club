#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 243 Task 2 Floor Sum
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of positive integers (>=1).
# Write a script to return the sum of floor(nums[i] / nums[j])
# where 0 <= i,j < nums.length.
# The floor() function returns the integer part of the division.
# Example 1 Input: @nums = (2, 5, 9)
#           Output: 10
#   floor(2 / 5) = 0
#   floor(2 / 9) = 0
#   floor(5 / 9) = 0
#   floor(2 / 2) = 1
#   floor(5 / 5) = 1
#   floor(9 / 9) = 1
#   floor(5 / 2) = 2
#   floor(9 / 2) = 4
#   floor(9 / 5) = 1
# Example 2 Input: @nums = (7, 7, 7, 7, 7, 7, 7)
#           Output: 49
#=============================================================================

use v5.38;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;
my $DoBenchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$DoBenchmark);
exit(!runTest()) if $DoTest;
exit(benchmark($DoBenchmark)) if $DoBenchmark;

die "Illegal value" if grep { $_ < 1 || $_ > $#ARGV } @ARGV;

say floorSum(@ARGV);

sub floorSum(@nums)
{
    my $sum = 0;
    for ( my $i = 0 ; $i <= $#nums ; $i++ )
    {
        for ( my $j = 0 ; $j <= $#nums ; $j++ )
        {
            $sum += int($nums[$i]/$nums[$j]);
        }
    }
    return $sum;
}

sub fs(@nums)
{
    my @N = sort { $b <=> $a } @nums;
    my $sum = 0;
    my $jstart = 0;
    for ( my $i = 0 ; $i <= $#N ; $i++ )
    {
        $jstart++ while ( $N[$jstart] > $N[$i] );
        for ( my $j = $jstart ; $j <= $#N && $N[$i] >= $N[$j] ; $j++ )
        {
            say "($i, $j) N[$i],N[$j] = $N[$i],$N[$j]" if $Verbose;
            $sum += int( $N[$i] / $N[$j] );
        }
    }
    return $sum;
}

sub fs_s(@nums)
{
    my $sum = scalar @nums;
    while ( my $i = shift @nums )
    {
        for my $j ( @nums )
        {
            $sum += int($i/$j) + int($j/$i);
        }
    }
    return $sum;
}

# Solution from James Curtis-Smith
sub fs_g(@nums)
{
    use POSIX qw/floor/;
    my $sum = scalar @nums;
    my $x;
    $x = pop @nums, grep { $sum += int($x/$_) + int($_/$x) } @nums while @nums;
    return $sum;
}

# Above solution, golf removed for readability, plus optimization
sub fs_m(@nums)
{
    #use builtin qw/floor/; no warnings "experimental::builtin";
    use integer;
    my $sum = scalar @nums;
    while ( @nums )
    {
        my $x = pop @nums;
        for ( @nums )
        {
            $sum += ($x/$_) + ($_/$x)
        }
    }
    return $sum;
}

sub runTest
{
    use Test2::V0;

    is( floorSum(2,5,9),         10, "Example 1");
    is( floorSum(7,7,7,7,7,7,7), 49, "Example 2");

    is( fs(2,5,9),         10, "fs Example 1");
    is( fs(7,7,7,7,7,7,7), 49, "fs Example 2");

    is( fs_s(2,5,9),         10, "fs_s Example 1");
    is( fs_s(7,7,7,7,7,7,7), 49, "fs_s Example 2");

    is( fs_g(2,5,9),         10, "fs_g Example 1");
    is( fs_g(7,7,7,7,7,7,7), 49, "fs_g Example 2");

    is( fs_m(2,5,9),         10, "fs_m Example 1");
    is( fs_m(7,7,7,7,7,7,7), 49, "fs_m Example 2");

    done_testing;
}

sub benchmark($repeat)
{
    use Benchmark qw/:all/;

    my @nums = ( map { rand(100) + 1 } 0 .. 99 );

    cmpthese($repeat, {
        'basic    ' => sub { floorSum(@nums) },
        'sort     ' => sub { fs(@nums) },
        #'sort pop ' => sub { fs_s(@nums) },
        'golf     ' => sub { fs_g(@nums) },
        'ungolf   ' => sub { fs_m(@nums) },
    });
}
