#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 077 Task #2 > Lonely X
#=============================================================================
# You are given m x n character matrix consists of O and X only.
# Write a script to count the total number of X surrounded by O only.
# Print 0 if none found.
# Example 1:
# Input: [ O O X ]
#        [ X O O ]
#        [ X O O ]
#
# Output: 1 as there is only one X at the first row last column surrounded by only O.

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use lib "lib";
use LonelyX;

sub Usage { "Usage: $0 args" };

my $arg = shift;
my @list = @ARGV;

die Usage() unless $arg;
die Usage() unless @list;

my $task = LonelyX->new();
my $result = $task->run();
say $result;
