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
#
# Alternative solution:  try to do as much as possible in one pass, without
# calculating the minimum of the window every time.

use strict;
use warnings;
use feature qw(say);

use Getopt::Long;

sub Usage { "Usage: $0 -w SIZE a b c ..." }

# Return the minimum of an array and the position where the minimum is located.
sub winMin
{
    my @arr = @_;

    my ($min, $where) = ( $arr[0], 0 );
    ( $arr[$_] < $min ) && (($min, $where) = ($arr[$_], $_)) for 1.. $#arr;
    return ($min, $where);
}

sub minSlidingWindow
{
    my ($aref, $winSize) = @_;

    # Find value and position of minimum in first window
    my ($min, $where) = winMin(@{$aref}[0..$winSize-1]);

    my @result = ($min);

    # Step through windows using first and next as boundaries.
    for ( my $first = 1, my $next = $winSize ; $next < scalar(@$aref) ; $first++, $next++ )
    {
        my $val = $aref->[$next];

        # Shift the position of the minimum to the left.  If it shifts
        # out of the window, find the new window minimum.
        if ( --$where  < 0 )
        {
            ($min, $where) = winMin( @{$aref}[$first..$next] );
        }
        elsif ( $val <= $min )
        {
            # If the new window is smaller, then that's the min and it's
            # at the right edge of the window.  No need to hunt for min.
            ($min, $where) = ($val, $winSize-1)
        }
        push @result, $min;
    }

    return \@result;
}

sub runTests
{
    use Test::More;

    my $min; my $where;
    ($min, $where) = winMin(1,2,3); is($min, 1);is($where, 0, "minWin first"); 
    ($min, $where) = winMin(3,1,2); is($min, 1);is($where, 1, "minWin middle"); 
    ($min, $where) = winMin(3,2,1); is($min, 1);is($where, 2, "minWin last"); 
    ($min, $where) = winMin(1,1,2); is($min, 1);is($where, 0, "minWin double"); 
    ($min, $where) = winMin(1,1,1); is($min, 1);is($where, 0, "minWin all same"); 

    is_deeply( minSlidingWindow( [0, 1, 2, 3], 2 ), [0,1,2] , "ascending" );

    is_deeply( minSlidingWindow( [ 1, 5, 0, 2, 9, 3, 7, 6, 4, 8 ], 3 ), [0,0,0,2,3,3,4,4] );

    done_testing();
}

my $doTest;
my $WinSize;
GetOptions('test!' => \$doTest, 'winsize:n' => \$WinSize);

exit(!runTests()) if $doTest;

die Usage() unless ($WinSize // 0) > 1;

my @A = @ARGV;

die Usage() unless scalar(@A) > $WinSize;

my $answer = minSlidingWindow(\@A, $WinSize);
say join(", ", @$answer);

my @a = map { int(rand(1000)) } ( 1..100000 );

say join(",", @a[0..200]);
$answer = minSlidingWindow(\@a, 100);
say join(",", @{$answer}[0..100]);
