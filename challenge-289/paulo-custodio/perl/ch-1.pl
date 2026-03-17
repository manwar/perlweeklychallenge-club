#!/usr/bin/env perl

# Perl Weekly Challenge 289 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-289/

use Modern::Perl;
use List::Util 'uniq';

my @nums = sort {$b <=> $a} uniq @ARGV;
say @nums>2 ? $nums[2] : $nums[0];
