#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 246 Task 1 6 out of 49
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 6 out of 49 is a German lottery.
# Write a script that outputs six unique random integers from the range 1 to 49.
#=============================================================================

use feature qw/say/;
say for sort { $a <=> $b} map { int(rand(49)) + 1 } 1..6;
