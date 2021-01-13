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

use strict;
use warnings;
use feature qw(say);

use Getopt::Long;

use List::Util qw(min);

use lib ".";
use MinSlidingWindow qw(minSlidingWindow);


sub Usage { "Usage: $0 -w SIZE a b c ..." }

my $WinSize;
GetOptions('winsize:n' => \$WinSize);

die Usage() unless ($WinSize // 0) > 1;

my @A = @ARGV;

die Usage() unless scalar(@A) > $WinSize;

my $answer = minSlidingWindow(\@A, $WinSize);
say join(", ", @$answer);
