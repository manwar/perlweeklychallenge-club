#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 228 Task 2 Empty Array
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers in which all elements are unique.
# Write a script to perform the following operations until the array is
# empty and return the total count of operations. If the first element is
# the smallest then remove it otherwise move it to the end.
# Example 1 Input: @int = (3, 4, 2)
#           Ouput: 5
#   Operation 1: move 3 to the end: (4, 2, 3)
#   Operation 2: move 4 to the end: (2, 3, 4)
#   Operation 3: remove element 2: (3, 4)
#   Operation 4: remove element 3: (4)
#   Operation 5: remove element 4: ()

# Example 2 Input: @int = (1, 2, 3)
#           Ouput: 3
#   Operation 1: remove element 1: (2, 3)
#   Operation 2: remove element 2: (3)
#   Operation 3: remove element 3: ()
#=============================================================================

use v5.36;

use List::Util qw/min/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub emptyArray(@int)
{
    my $opCount = 0;
    while ( @int )
    {
        say "(", join(",", @int), ")" if $Verbose;
        $opCount++;

        # Remove first element
        my $front = shift(@int);

        # Put it on the end if it wasn't the smallest
        push @int, $front if @int && $front > min(@int);
    }
    return $opCount;
}

sub runTest
{
    use Test2::V0;

    is( emptyArray(3,4,2), 5, "Example 1");
    is( emptyArray(1,2,3), 3, "Example 2");
    is( emptyArray(5,4,3), 6, "Reverse order");
    is( emptyArray(7    ), 1, "Singleton");
    is( emptyArray(     ), 0, "Empty list");


    done_testing;
}
