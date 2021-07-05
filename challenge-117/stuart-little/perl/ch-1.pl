#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <path-to-file>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use File::Slurp qw(read_file);
use List::AllUtils qw(sum);

my @lines = (scalar @ARGV) ? (read_file($ARGV[0])) : (<DATA>);
say(((scalar @lines)+1)*((scalar @lines) + 2)/2 - sum map {/^[^\d]*(\d+)/; int($1)} @lines );

__DATA__
11, Line Eleven
1, Line one
9, Line Nine
13, Line Thirteen
2, Line two
6, Line Six
8, Line Eight
10, Line Ten
7, Line Seven
4, Line Four
14, Line Fourteen
3, Line three
15, Line Fifteen
5, Line Five
