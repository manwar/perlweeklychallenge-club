#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 077 Task #1 > Fibonacci Sum
#=============================================================================
# You are given a positive integer $N.
# Write a script to find out all possible combination of Fibonacci Numbers
# required to get $N on addition.
# You are NOT allowed to repeat a number. Print 0 if none found.

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use lib "lib";
use FibSum;

sub Usage { "Usage: $0 args" };

my $arg = shift;
my @list = @ARGV;

die Usage() unless $arg;
die Usage() unless @list;

my $task = FibSum->new();
my $result = $task->run();
say $result;
