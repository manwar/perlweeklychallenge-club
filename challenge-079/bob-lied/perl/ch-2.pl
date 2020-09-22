#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 079 Task #2 > Trapped Rain Water
#=============================================================================
# You are given an array of positive numbers @N.
# Write a script to represent it as Histogram Chart and find out how much
# water it can trap.
# Example 1: Input: (2, 1, 4, 1, 2, 5)
# As historgram:   5           #
#                  4     #     #
#                  3     #     #
#                  2 #   #   # #
#                  1 # # # # # #
#                  _ _ _ _ _ _ _
#                    2 1 4 1 2 5
# Concave units that can trap water:
#                  5           |
#                  4     | O O |
#                  3     | O O |
#                  2 | O | O _ |
#                  1 | _ | _ | |
#                  _ _ _ _ _ _ _
#                    2 1 4 1 2 5
# Answer: 6

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
