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

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(minSlidingWindow);
our @EXPORT_OK = qw();

use List::Util qw(min);

sub minSlidingWindow
{
    my ($aref, $win) = @_;
    my @result;

    for my $beg ( 0 .. scalar(@$aref) - $win )
    {
        my $min = List::Util::min( @{$aref}[$beg .. $beg+$win-1 ]);
        push @result, $min;
    }
    return \@result;
}

1;
