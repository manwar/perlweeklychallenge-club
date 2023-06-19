#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 218 Task 1  Maximum Product
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Task 1: Maximum Product
# You are given a list of 3 or more integers.
# Write a script to find the 3 integers whose product is the maximum.
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say maxProd(@ARGV);

sub maxProd(@list)
{
    use integer;
    my $maxprod = -(2**63);
    for (my $x = 0 ; $x < $#list-1 ; $x++ )
    {
        for (my $y = $x+1 ; $y < $#list; $y++ )
        {
            for (my $z = $y+1 ; $z <= $#list; $z++ )
            {
                my $prod = $list[$x] * $list[$y] * $list[$z];
                say "(x,y,z)=($x,$y,$z)  $prod=$list[$x]*$list[$y]+$list[$z]" if $Verbose;
                $maxprod = $prod if $prod > $maxprod;
            }
        }
    }
    return $maxprod;
}

sub runTest
{
    use Test2::V0;

    is( maxProd( 3, 1,  2          ),   6, "Example 1");
    is( maxProd( 4, 1,  3, 2       ),  24, "Example 2");
    is( maxProd(-1, 0,  1, 3,  1   ),   3, "Example 3");
    is( maxProd(-8, 2, -9, 0, -4, 3),  216, "Example 4");

    done_testing;
}

