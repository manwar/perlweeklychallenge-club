#!/usr/bin/perl
use warnings;
use strict;

use ARGV::OrDATA;

my %invert = qw( L R R L );

print s/ ([LR]) / $invert{$1} /r while <DATA>;

__DATA__
4 L 2
5 R 2
6 L 3
7 R 3
2 L 1
3 R 1
