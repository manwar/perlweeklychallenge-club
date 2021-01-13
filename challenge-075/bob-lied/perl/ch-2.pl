#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 075 TASK #2> Largest Rectangle Histogram 
#=============================================================================
# You are given an array of positive numbers @A.
# Write a script to find the largest rectangle histogram created by the given array.
# BONUS: Try to print the histogram as shown in the example, if possible.

use strict;
use warnings;
use feature q(say);

use lib "lib";
use LargestRectangleHistogram;

my @A = @ARGV;
die "Usage: list of positive integers" unless @A;

my $lrh = LargestRectangleHistogram->new(@A);

# $lrh->_show();
say "Max area: ", $lrh->findLRH();

$lrh->display();

