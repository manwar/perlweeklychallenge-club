#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 002, Task #1, Remove Leading Zeroes
# Write a script or one-liner to remove leading zeros from positive numbers.
#=============================================================================

use strict;
use warnings;
use 5.020;

# Adding 0 forces interpretation as a number, loses leading zeroes
for ( @ARGV ) { say $_+0; }
