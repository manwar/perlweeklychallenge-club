#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 252 Task 2 Unique Sum Zero
#=============================================================================
# You are given an integer, $n.  Write a script to find an array containing
# $n unique integers such that they add up to zero.
# Example 1 Input: $n = 5
#           Output: (-7, -1, 1, 3, 4)
#   Two other possible solutions could be as below:
#   (-5, -1, 1, 2, 3) and (-3, -1, 2, -2, 4).
# Example 2 Input: $n = 3
#           Output: (-1, 0, 1)
# Example 3 Input: $n = 1
#           Output: (0)
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub usz($n)
{
    my @list;
    my $pick = 2;
    while ( $n > 0 )
    {
        if ( $n == 1 )
        {
            push @list, 0;
            $n -= 1;
        }
        elsif ( $n == 2 )
        {
            push @list, (1, -1);
            $n -= 2;
        }
        else
        {
            push @list, ( $pick, $pick+1, -($pick+$pick+1) );
            $pick += 2;
            $n -= 3;
        }
    }
    say "\@usz=(@list)" if $Verbose;
    return @list;
}

sub usz2($n)
{
    return ( $n == 0 ? () : ( (1 .. $n-1), -( $n*($n-1)/2 ) ) );
}

sub runTest
{
    use Test2::V0;
    use List::Util qw/sum0 uniqint/;

    my @usz;

    for my $n ( 0 .. 5 )
    {
        @usz = usz($n);
        is( scalar(@usz),                    $n, "n=$n count");
        is( sum0(@usz),                       0, "n=$n sum");
        is( scalar(uniqint(@usz)), scalar(@usz), "n=$n unique");
    }

    for my $n ( reverse 0 .. 5 )
    {
        @usz = usz2($n);
        is( scalar(@usz),                    $n, "usz2 n=$n count");
        is( sum0(@usz),                       0, "nusz2 =$n sum");
        is( scalar(uniqint(@usz)), scalar(@usz), "nusz2 =$n unique");
    }

    done_testing;
}
