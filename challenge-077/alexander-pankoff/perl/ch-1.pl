#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

# You are given a positive integer $N.
#
# Write a script to find out all possible combination of Fibonacci Numbers required to get $N on addition.
#
# You are NOT allowed to repeat a number. Print 0 if none found.
