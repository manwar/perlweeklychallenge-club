#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge Task #2 > FNR Character
#=============================================================================
# You are given a string $S.
# Write a script to print the series of first non-repeating character (left
# to right) for the given string.  Print # if none found
# Example:
# Input: $S = 'ababc'
# Output: 'abb#c'
# Pass 1: "a"     the FNR character is 'a'
# Pass 2: "ab"    the FNR is 'b'
# Pass 3: "aba"   the FNR is 'b'
# Pass 4: "abab"  the FNR is '#' (all chars repeat)
# Pass 5: "ababc" the FNR is 'c'
#
# Note that this example is actually taking the right-most character as
# the first non-repeater, which is counter-intuitive to the specification.

use strict;
use warnings;

use lib "lib";
use FNR qw(firstNonRepeat);

my $S = shift;

die "Need a string" unless $S;

say firstNonRepeat($S);
