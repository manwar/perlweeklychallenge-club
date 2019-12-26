#! /usr/bin/perl

use strict;
use warnings;

my @list=(10, 4, 1, 8, 12, 3);
my @indices=(0,2,5);

my @s=sort {$a <=> $b} map {$list[$_]} @indices;
map {$list[$indices[$_]]=$s[$_]} (0..$#indices);

print join(', ',@list),"\n";
