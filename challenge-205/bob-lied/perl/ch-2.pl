#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Maximum XOR
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to find the highest value obtained by XORing any two
# distinct members of the array.
# Example 1 Input: @array = (1,2,3,4,5,6,7) Output: 7
#   The maximum result of 1 xor 6 = 7.
# Example 2 Input: @array = (2,4,1,3) Output: 7
#   The maximum result of 4 xor 3 = 7.
# Example 3 Input: @array = (10,5,7,12,8) Output: 15
#   The maximum result of 10 xor 5 = 15.
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub maxXOR($array)
{
    return 0 if scalar(@$array) == 0;

    my $N = $#{$array};

    # For a single element, return itself. Debatable because x^x == 0
    return $array->[0] if $N == 0;

    my $max = ( $array->[0] ^ $array->[1] );

    # Consider evey combination of pairs. Because XOR is commutative, we
    # only need to go through one ordering, not the complete NxN set.

    # This loop goes to N-1, so j can go to N
    for ( my $i = 0 ; $i < $N ; $i++ )
    {
        # j starts after i and goes to the very end
        for ( my $j = $i+1; $j <= $N ; $j++ )
        {
            my $xor = ( $array->[$i] ^ $array->[$j] );
            $max = $xor if $xor > $max;
        }
    }
    return $max;
}

sub runTest
{
    use Test2::V0;

    is( maxXOR([1,2,3,4,5,6,7 ]),   7, "Example 1");
    is( maxXOR([2,4,1,3       ]),   7, "Example 2");
    is( maxXOR([10,5,7,12,8   ]),  15, "Example 3");
    is( maxXOR([139           ]), 139, "Singleton");
    is( maxXOR([              ]),   0, "Empty");
    is( maxXOR([0x5, 0x8,  0x2]),  13, "Test 1");
    is( maxXOR([0x6, 0x8,  0x2]),  14, "Test 2");
    is( maxXOR([0x6, 0x8, 0x10]),  24, "Test 3");

    done_testing;
}

