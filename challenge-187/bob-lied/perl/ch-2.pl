#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 187 Task 2 Magical Triplets
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of positive numbers, @n, having at least 3 numbers.
# Write a script to find the triplets (a, b, c) from the given list that
# satisfies the following rules.
#   1. a + b > c
#   2. b + c > a
#   3. a + c > b
#   4. a + b + c is maximum.
# In case, you end up with more than one triplet having the maximum then
# pick the triplet where a >= b >= c.
#
# Example 1 Input: @n = (1, 2, 3, 2); Output: (3, 2, 2)
# Example 2 Input: @n = (1, 3, 2);    Output: ()
# Example 3 Input: @n = (1, 1, 2, 3); Output: ()
# Example 4 Input: @n = (2, 4, 3);    Output: (4, 3, 2)
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

use Memoize;
memoize('_check');
sub _check($a, $b, $c)
{
    if ( $a + $b > $c && $b + $c > $a && $a + $c > $b )
    {
        say "CHECK: ($a $b $c)" if $Verbose;
        return $a + $b + $c;
    }
    return -1;
}

sub magic($list)
{
    my $n = scalar(@$list);
    my @result = ();
    my $max = 0;

    my ($a, $b, $c);
    for ( my $i = 0 ; $i < $n ; $i++ )
    {
        for ( my $j = 0; $j < $n ; $j++ )
        {
            next if $j == $i;
            ($a, $b) = $list->@[$i,$j];

            for ( my $k = 0 ; $k < $n ; $k++ )
            {
                next if $k == $i || $k == $j;

                $c = $list->[$k];
                if ( (my $sum = _check($a, $b, $c)) > $max )
                {
                    say "  CHOSE: [$a,$b,$c] = $sum" if $Verbose;
                    @result = ($a, $b, $c);
                    $max = $sum;
                }
                elsif ( $sum == $max )
                {
                    if ( $a >= $b && $b >= $c )
                    {
                        say "  CHOSE: [$a,$b,$c] = $sum" if $Verbose;
                        @result = ( $a, $b, $c );
                    }
                }
            }
        }
    }

    return \@result;
}

sub runTest
{
    use Test2::V0;

    is( magic( [ 1,2,3,2] ), [3,2,2], "Example 1");
    is( magic( [ 1,3,2  ] ), [     ], "Example 2");
    is( magic( [ 1,1,2,3] ), [     ], "Example 3");
    is( magic( [ 2,4,3  ] ), [4,3,2], "Example 4");

    done_testing;
}
