#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 079 Task #1 > Count Set Bits
#=============================================================================
# You are given a positive number $N.
# Write a script to count the total numbrer of set bits of the binary
# representations of all numbers from 1 to $N and
# return $total_count_set_bit % 1000000007.
# Example 1: Input = 4
#   1 --> 001  Count = 1
#   2 --> 010  Count = 1
#   3 --> 011  Count = 2
#   4 --> 100  Count = 1
#   TOTAL: 5

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use Getopt::Long;

use lib "lib";
use CountSetBit;

sub Usage { "Usage: $0 N \t\t# N > 0" };

my $Verbose = 0;
GetOptions('verbose' => \$Verbose);

my $N = shift;

die Usage() unless $N && $N >= 0;

my $task = CountSetBit->new($N);
my $result = $task->run();
say $result;
