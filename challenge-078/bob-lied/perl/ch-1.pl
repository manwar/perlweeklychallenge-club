#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 078 Task #1 > Leader Element
#=============================================================================
# You are given an array @A containing distinct integers.
# Write a script to find all leader elements in the array @A.  Print (0) if
# none found.
# An element is a leader if it is greater than all the elements to its right.
# Example 1:
# Input: @A = (9, 10, 7, 5, 6, 1)
# Ouput: (10, 7, 6, 1)

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use Getopt::Long;

use lib "lib";
use Task1;

sub Usage { "Usage: $0 args" };

my $Verbose = 0;
GetOptions('verbose' => \$Verbose);

my $arg = shift;
my @list = @ARGV;

die Usage() unless $arg;
die Usage() unless @list;

my $task = Task1->new();
my $result = $task->run();
say $result;
