#!/usr/bin/perl
use warnings;
use strict;

use ARGV::OrDATA;

print tr/LR/RL/r while <DATA>;

__DATA__
4 L 2
5 R 2
6 L 3
7 R 3
2 L 1
3 R 1
