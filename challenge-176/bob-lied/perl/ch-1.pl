#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 176 Task 1 Permuted Multiples
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Write a script to find the smallest positive integer x
# such that x, 2x, 3x, 4x, 5x and 6x are permuted multiples of each other.
# For example, the integers 125874 and 251748 are permutated multiples
# of each other as 251784 = 2 x 125874
# and also both have the same digits but in different order.
# Output 142857
#=============================================================================

use v5.36;

use builtin qw/true false/;
no warnings "experimental::builtin";

use List::Util qw/all/;

use Getopt::Long;
my $DoTest  = false;
my $DoAll = false;
my $Size = 6;

GetOptions("test" => \$DoTest, "all" => \$DoAll, "size:i" => \$Size);
exit(!runTest()) if $DoTest;

sub isPermutation($digits, $m)
{
    my @m = sort split("", $m);
    return false if $#m != $#{$digits};
    return all { $digits->[$_] == $m[$_] } 0 .. $#m;
}

say join(" ", smallestPermuted($Size, $DoAll)->@*);

sub smallestPermuted($size = 6, $doAll = false)
{
    my @result;
    MAG: for ( my $magnitude = 100 ; $magnitude <= 10**$size ; $magnitude *= 10 )
    {
        my $max = int( $magnitude / 6 );
        my $base = int ( $max / 10 );
        for ( my $i = $base + 1 ; $i <= $base + $max ; $i++ )
        {
            my @digits = sort split("", $i);

            if ( all { isPermutation(\@digits, $i * $_) }  2 .. 6 )
            {
                push @result, $i;
                last MAG unless $doAll;
            }
        }
    }
    return \@result;
}

sub runTest
{
    use Test2::V0;

    is( smallestPermuted(2), [], "2 digits");
    is( smallestPermuted(3), [], "3 digits");
    is( smallestPermuted(4), [], "4 digits");
    is( smallestPermuted(5), [], "5 digits");
    is( smallestPermuted(6), [ 142857 ], "6 digits");

    done_testing;
}

