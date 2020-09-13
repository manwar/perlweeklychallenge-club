#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

# You are given m x n character matrix consists of O and X only.
#
# Write a script to count the total number of X surrounded by O only. Print 0 if none found.
