#!/usr/bin/env perl
use strict;
use warnings;

my @a=(10,4,1,8,12,3);
my @i=(0,2,5);

$,=" ";
print sort {$a <=> $b} @a[@i];
