#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 210 Task 2 Number Collision 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers which can move in right direction if it
# is positive and left direction when negative. If two numbers collide then
# the smaller one will explode. And if both are same then they both explode.
# We take the absolute value in consideration when comparing.
# All numbers move at the same speed, therefore any 2 numbers moving in the
# same direction will never collide.
# Write a script to find out who survives the collision.
# Example 1: Input: @list = (2, 3, -1) Output: (2, 3)
#   The numbers 3 and -1 collide and -1 explodes in the end.
#   So we are left with (2, 3).
#   Only positive numbers are left, so no more collisions will happen.
# Example 2: Input: @list = (3, 2, -4) Output: (-4)
#   The numbers 2 and -4 collide and 2 explodes in the end.
#   That gives us (3, -4).
#   Now the numbers 3 and -4 collide and 3 explodes.
#   Finally we are left with -4.
# Example 3: Input: @list = (1, -1) Output: ()
#   The numbers 1 and -1 both collide and explode. Nothing left in the end.
#=============================================================================

use v5.36;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(',', numberCollision(@ARGV)->@*), ")";

sub numberCollision(@list)
{
    my $collision = true;
    while ( $collision )
    {
        $collision = false;
        for ( my $i = 0 ; $i < $#list ; $i++ )
        {
            my ($left, $right) = @list[$i, $i+1];
            next unless ( $left >= 0 && $right < 0 );

            $collision = true;
            if ( abs($left) == abs($right) )
            {
                # Both explode
                splice(@list, $i, 2);
            }
            else
            {
                my $keep = ( abs($left) > abs($right) ? $left : $right );
                # Replace the pair with the larger one
                splice(@list, $i, 2, $keep);
            }
        }
    }
    return [ @list ];
}

sub runTest
{
    use Test2::V0;

    is( numberCollision(2,3,-1), [2,3], "Example 1");
    is( numberCollision(3,2,-4), [ -4], "Example 2");
    is( numberCollision(1,  -1), [   ], "Example 3");

    is( numberCollision(1     ), [ 1 ], "Singleton");
    is( numberCollision(1,2,3 ), [ 1,2,3 ], "No collision positive");
    is( numberCollision(-1,-2,-3 ), [ -1,-2,-3 ], "No collision negative");
    is( numberCollision(-1,-2,3,4 ), [ -1,-2,3,4 ], "No collision");

    done_testing;
}

