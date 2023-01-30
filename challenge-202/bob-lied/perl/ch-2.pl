#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 202 Task 2 Widest Valley
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Given a profile as a list of altitudes, return the leftmost widest valley.
# A valley is defined as a subarray of the profile consisting of two parts:
# the first part is non-increasing and the second part is non-decreasing.
# Either part can be empty.
# Example 1 Input: 1, 5, 5, 2, 8
#          Output:    5, 5, 2, 8
# Example 2 Input: 2, 6, 8, 5
#          Output: 2, 6, 8
# Example 3 Input: 9, 8, 13, 13, 2, 2, 15, 17
#                Output: 13, 13, 2, 2, 15, 17
# Example 4 Input: 2, 1, 2, 1, 3
#          Output: 2, 1, 2
# Example 5 Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
#             Output: 3, 3, 2, 1, 2, 3, 3
#=============================================================================

use v5.36;

# State machine states
use constant S_START                  => 0;
use constant S_CLIMB                  => 1;
use constant S_DESCEND                => 2;
use constant S_FLAT_WHILE_CLIMBING    => 3;
use constant S_FINISH                 => 4;

# Valleys are represented as (start, end) pairs
use constant V_BEGIN => 0;
use constant V_END   => 1;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $wide = widestValley(\@ARGV);
say "(", join(",", $wide->@*), ")";

sub widestValley($profile)
{
    return $profile if @$profile < 3;

    # Save a list of all valleys found and evaluate for the widest
    # after we've gone throught the profile.
    my @valleyList; # (start, end) pairs
    my @valley = (0,0);

    # To handle flat sections that could be up or down
    my $flatStart = 0;

    my $state = S_START;
    my $place = 0;
    my $endOfProfile = @$profile - 1;

    while ( $state != S_FINISH )
    {
        say "STATE=$state place=$place v=(@valley)" if $Verbose;
        if ( $state == S_START )
        {
            @valley = ( 0, 1 );
            $place = 1;
            $state = ( $profile->[1] <= $profile->[0] ) ? S_DESCEND : S_CLIMB;
        }
        elsif ( $state == S_CLIMB )
        {
            if ( $place == $endOfProfile )
            {
                $valley[V_END] = $place;
                push @valleyList, [ @valley ];
                $state = S_FINISH;
                next;
            }

            my $step = ( $profile->[$place+1] <=> $profile->[$place] );
            if ( $step > 0 )
            {
                $state = S_CLIMB;
                $valley[V_END] = ++$place;
            }
            elsif ( $step < 0 )
            {
                # Reverse direction. Start a new valley.
                $state = S_DESCEND;
                $valley[V_END] = $place;
                push @valleyList, [ @valley ];
                @valley = ($place, $place+1);
                $place++;
            }
            elsif ( $step == 0 )
            {
                # We are moving horizontally in a flat section.
                # If we descend at the end of the flat section, we need
                # to know where the flat started to get the beginning
                # of a subsequent valley. Meanwhile, we're still "climbing"
                # in the current valley.
                $state = S_FLAT_WHILE_CLIMBING;
                $flatStart = $place;
                $valley[V_END] = ++$place;
            }
        }
        elsif ( $state == S_FLAT_WHILE_CLIMBING )
        {
            if ( $place == $endOfProfile )
            {
                $valley[V_END] = $place;
                push @valleyList, [ @valley ];
                $state = S_FINISH;
                next;
            }
            my $step = ( $profile->[$place+1] <=> $profile->[$place] );
            if ( $step == 0 )
            {
                $state = S_FLAT_WHILE_CLIMBING;
                $valley[V_END] = ++$place;
            }
            elsif ( $step > 0 )
            {
                $state = S_CLIMB;
                $valley[V_END] = ++$place;
            }
            else # $step < 0
            {
                # We flattened out and then reversed to downhill.  Finish the
                # current uphill at the end of the flat, and start a new valley
                # where the downhill starts back at the beginning of the flat.
                
                $state = S_DESCEND;
                $valley[V_END] = $place;
                push @valleyList, [ @valley ];
                @valley = ( $flatStart, ++$place );
            }
        }
        elsif ( $state = S_DESCEND )
        {
            if ( $place == $endOfProfile )
            {
                $valley[V_END] = $place;
                push @valleyList, [ @valley ];
                $state = S_FINISH;
                next;
            }
            my $step = ( $profile->[$place+1] <=> $profile->[$place] );
            if ( $step <= 0 )
            {
                $state = S_DESCEND;
                $valley[V_END] = ++$place;
            }
            else
            {
                $state = S_CLIMB;
                $valley[V_END] = ++$place;
            }
        }
    }

    my $maxWidth = 0;
    my $widest = $valleyList[0];
    for my $v ( @valleyList )
    {
        my $width = $v->[V_END] - $v->[V_BEGIN];
        if ( $width > $maxWidth )
        {
            $maxWidth = $width;
            $widest = $v;
        }
    }

    return [ $profile->@[ $widest->[V_BEGIN] .. $widest->[V_END] ] ];
}

sub runTest
{
    use Test2::V0;

    is( widestValley([1,5,5,2,8          ]), [5,5,2,8        ], "Example 1");
    is( widestValley([2,6,8,5            ]), [2,6,8          ], "Example 2");
    is( widestValley([9,8,13,13,2,2,15,17]), [13,13,2,2,15,17], "Example 3");
    is( widestValley([2,1,2,1,3          ]), [2,1,2          ], "Example 4");
    is( widestValley([1,3,3,2,1,2,3,3,2  ]), [3,3,2,1,2,3,3  ], "Example 5");

    done_testing;
}
