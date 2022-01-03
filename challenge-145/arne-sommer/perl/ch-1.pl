#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'sum';

my $a = shift(@ARGV) // '1 2 3';
my $b = shift(@ARGV) // '4 5 6';

my @a = split(/\s+/, $a);
my @b = split(/\s+/, $b);

die '@a and @b must have the same size' unless @a == @b;

say sum(map { $a[$_] * $b[$_] } (0 .. @a -1));
