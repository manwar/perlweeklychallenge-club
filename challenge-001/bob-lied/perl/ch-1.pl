#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 001, Task #1 Replace with E
# Write a script to replace the character ‘e’ with ‘E’ in the string
# ‘Perl Weekly Challenge’.
# Also print the number of times the character ‘e’ is found in the string.
#=============================================================================

use strict;
use warnings;
use 5.020;

my $s = 'Perl Weekly Challenge';

my $count = $s =~ tr/e/E/;

say $s;
say $count;
