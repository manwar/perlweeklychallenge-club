#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 073 Task #1 > Min Sliding Window
#=============================================================================
#
# You are given an array of integers @A and sliding window size $S.
# Write a script to create an array of min from each sliding window.

package MinSlidingWindow;

use strict;
use warnings;
use feature qw(say);

use lib ".";
use MinSlidingWindow;

use Test::More;

is_deeply( minSlidingWindow( [0, 1, 2, 3], 2 ), [0,1,2] , "ascending" );

is_deeply( minSlidingWindow( [ 1, 5, 0, 2, 9, 3, 7, 6, 4, 8 ], 3 ), [0,0,0,2,3,3,4,4] );

done_testing();
