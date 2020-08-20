#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 074 Task #1 > Majority Element
#=============================================================================
# You are given an array of integers of size $N.
# Write a script to find the majority element.  If none found, then print -1.
# Majority element in the list is the one that appears more than floor($N/2).

use strict;
use warnings;
use feature qw(say);

use lib "lib";
use MajorityElement;

my @ARR = @ARGV;

die "Give a list of integers" unless @ARR;

say majorityElement(@ARR);
