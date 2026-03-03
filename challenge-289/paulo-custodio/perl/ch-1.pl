#!/usr/bin/env perl

use Modern::Perl;
use List::Util 'uniq';

my @nums = sort {$b <=> $a} uniq @ARGV;
say @nums>2 ? $nums[2] : $nums[0];
