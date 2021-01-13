#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 083 Task #2 > Flip Array
#=============================================================================
# You are given an array @A of positive numbers.
# Write a script to flip the sign of some members of the given array so that
# the sum of the all members is minimum non-negative.
# Given an array of positive elements, you have to flip the sign of some of
# its elements such that the resultant sum of the elements of array should be
# minimum non-negative(as close to zero as possible). Return the minimum no.
# of elements whose sign needs to be flipped such that the resultant sum is
# minimum non-negative.
# Example 1: Input: @A = (3, 10, 8)     Output: 1
# Explanation: Flipping the sign of just one element 10 gives the result 1 i.e.
#               (3) + (-10) + (8) = 1
# 
# Example 2: Input: @A = (12, 2, 10)    Output: 1
# Explanation: Flipping the sign of just one element 12 gives the result 0 i.e.
#               (-12) + (2) + (10) = 0

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use Getopt::Long;

use lib "lib";
use Task2;

sub Usage { "Usage: $0 args" };

my $Verbose = 0;
GetOptions('verbose' => \$Verbose);

my $arg = shift;
my @list = @ARGV;

die Usage() unless $arg;
die Usage() unless @list;

my $task = Task2->new();
my $result = $task->run();
say $result;
