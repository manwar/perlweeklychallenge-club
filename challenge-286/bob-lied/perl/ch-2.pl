#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 286 Task 2 Order Game
#=============================================================================
# You are given an array of integers, @ints, whose length is a power of 2.
# Write a script to play the order game (min and max) and return the
# last element.
# Example 1 Input: @ints = (2, 1, 4, 5, 6, 3, 0, 2)
#           Output: 1
#   Operation 1: min(2, 1) = 1 max(4, 5) = 5 min(6, 3) = 3 max(0, 2) = 2
#   Operation 2: min(1, 5) = 1 max(3, 2) = 3
#   Operation 3: min(1, 3) = 1
# Example 2 Input: @ints = (0, 5, 3, 2)
#           Output: 0
#   Operation 1: min(0, 5) = 0 max(3, 2) = 3
#   Operation 2: min(0, 3) = 0
# Example 3 Input: @ints = (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)
#           Output: 2
#   Operation 1: min(9, 2) = 2 max(1, 4) = 4 min(5, 6) = 5 max(0, 7) = 7
#                min(3, 1) = 1 max(3, 5) = 5 min(7, 9) = 7 max(0, 8) = 8
#   Operation 2: min(2, 4) = 2 max(5, 7) = 7 min(1, 5) = 1 max(7, 8) = 8
#   Operation 3: min(2, 7) = 2 max(1, 8) = 8
#   Operation 4: min(2, 8) = 2
#=============================================================================

use v5.40;

use List::Util qw/min max/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say orderGame(@ARGV);

sub orderGame($ints)
{
    my $length = scalar(@{$ints});
    return undef if ($length & ($length-1)) != 0;

    while ( $#{$ints} > 0 )
    {
        my @list;
        foreach ( 0 .. int($#{$ints}/2) )
        {
            push @list, ( $_ % 2 == 0 )
                    ? ($ints->[$_] < $ints->[$_+1] ? $ints->[$_] : $ints->[$_+1])
                    : ($ints->[$_] > $ints->[$_+1] ? $ints->[$_] : $ints->[$_+1]) 
        }
        $ints = \@list;
    }
    return $ints->[0] // undef;
}

sub og2($ints)
{
    my $length = scalar(@{$ints});
    return undef if ($length & ($length-1)) != 0;

    my $op = 0;
    while ( $ints->$#* > 0 )
    {
        $ints = [ map  {
                ($op = !$op)
                    ? ($ints->[$_] < $ints->[$_+1] ? $ints->[$_] : $ints->[$_+1])
                    : ($ints->[$_] > $ints->[$_+1] ? $ints->[$_] : $ints->[$_+1]) 
                } 0 .. (($ints->$#* / 2)) ];
    }
    return $ints->[0] // undef;
}

sub og3($ints)
{
    use List::MoreUtils qw/natatime/;
    my $length = scalar(@{$ints});
    return undef if ($length & ($length-1)) != 0;
    my $op = 1;
    while ( $ints->$#* > 0 )
    {
        my @list;
        my $iter = natatime 2, @{$ints};
        while ( my @pair = $iter->() )
        {
            push @list, ($op ? min(@pair) : max(@pair));
            $op = !$op
        }
        $ints = \@list;
    }
    return $ints->[0] // undef;
}

sub og4($ints)
{
    my $length = scalar(@{$ints});
    return undef if ($length & ($length-1)) != 0;

    my $op = 0;
    while ( scalar(@{$ints}) > 1 )
    {
        my @list;
        foreach my ($i, $j) ( $ints->@* )
        {
            push @list, (( $op = !$op ) ? min($i,$j) : max($i,$j));
        }
        $ints = \@list;
    }
    return $ints->[0] // undef;
}

sub og5($ints)
{
    my $length = scalar(@{$ints});
    return undef if ($length & ($length-1)) != 0;
    my $op = 0;
    while ( @{$ints} > 1 )
    {
        for ( 0 ..  int($#{$ints}/2) )
        {
            splice @$ints, $_, 2,
                 (( $op = !$op )
                    ? ($ints->[$_] < $ints->[$_+1] ? $ints->[$_] : $ints->[$_+1])
                    : ($ints->[$_] > $ints->[$_+1] ? $ints->[$_] : $ints->[$_+1]) ) 
        }
    }
    return $ints->[0] // undef;
}


sub runTest
{
    use Test2::V0;

    is( orderGame([8,3]),             3,                 "One pair");
    is( orderGame([2,1,4,5,6,3,0,2]), 1,                 "Example 1");
    is( orderGame([0,5,3,2]),         0,                 "Example 2");
    is( orderGame([9,2,1,4,5,6,0,7,3,1,3,5,7,9,0,8]), 2, "Example 3");

    is( orderGame([]),    undef, "Empty list");
    is( orderGame([1,2,3]), undef, "Length != 2^x");

    is( og2([8,3]),             3,                 "One pair");
    is( og2([2,1,4,5,6,3,0,2]), 1,                 "Example 1");
    is( og2([0,5,3,2]),         0,                 "Example 2");
    is( og2([9,2,1,4,5,6,0,7,3,1,3,5,7,9,0,8]), 2, "Example 3");

    is( og3([8,3]),             3,                 "One pair");
    is( og3([2,1,4,5,6,3,0,2]), 1,                 "Example 1");
    is( og3([0,5,3,2]),         0,                 "Example 2");
    is( og3([9,2,1,4,5,6,0,7,3,1,3,5,7,9,0,8]), 2, "Example 3");

    is( og4([8,3]),             3,                 "One pair");
    is( og4([2,1,4,5,6,3,0,2]), 1,                 "Example 1");
    is( og4([0,5,3,2]),         0,                 "Example 2");
    is( og4([9,2,1,4,5,6,0,7,3,1,3,5,7,9,0,8]), 2, "Example 3");

    is( og5([8,3]),             3,                 "One pair");
    is( og5([2,1,4,5,6,3,0,2]), 1,                 "Example 1");
    is( og5([0,5,3,2]),         0,                 "Example 2");
    is( og5([9,2,1,4,5,6,0,7,3,1,3,5,7,9,0,8]), 2, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my @ints = ( int(rand(10) ) x 512 );

    cmpthese($repeat, {
        basic    => sub { orderGame(\@ints) },
        map      => sub { og2(\@ints) },
        natatime => sub { og3(\@ints) },
        foreach  => sub { og4(\@ints) },
        splice   => sub { og5(\@ints) },
    });
}
