#!/usr/bin/perl

use strict;
use v5.10;

my @list = @ARGV;
if (@list % 2) {say "Not an even number of items." && exit};
my $split = @list / 2;
my @sorted = sort { $a <=> $b } @list;
say $sorted[0] + $sorted[$split];