#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 078 Task #2 > Left Rotation
#=============================================================================
# You are given an array @A containing positive numbers and @B containing one
# or more indices from @A.
# Write a script to left-rotate @A so that the number at the first index of @B
# becomes the first element in the array. Similary, left rotate @A again so
# that the number at the second index of @B becomes the first element in the
# array.
# Example 1:
# Input: @A = (10 20 30 40 50)
#        @B = (3 4)
# a) We left rotate the 3rd index element (40) in the @A to make it 0th index
# member in the array.
#   [40 50 10 20 30]
#
# b) We left rotate the 4th index element (50) in the @A to make it 0th index
# member in the array.
#   [50 10 20 30 40]
#
# Output:
#   [40 50 10 20 30]
#   [50 10 20 30 40] 

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
