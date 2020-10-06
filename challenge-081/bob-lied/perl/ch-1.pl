#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 081 Task #1 > Common Base String
#=============================================================================
# You are given 2 strings, $A and $B.
# Write a script to find out common base strings in $A and $B.
# A substring of a string $S is called base string if repeated concatenation
# of the substring results in the string.
# Example 1: Input: $A = "abcdabcd"
#                   $B = "abcdabcdabcdabcd"
#           Output: ("abcd", "abcdabcd")
#
# Example 2: Input: $A = "aaa"
#                   $B = "aa"
#           Output: ("a")

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use Getopt::Long;

use lib "lib";
use CommonBaseString;

sub Usage { "Usage: $0 astring bstring" };

my $Verbose = 0;
GetOptions('verbose' => \$Verbose);

my (@A, @B) = @ARGV;

die Usage() unless $A;
die Usage() unless $B;

my $cbs = CommonBaseString->new($A, $B);
my $result = $cbs->run();
say $result;
