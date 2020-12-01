#! /usr/bin/env perl

use strict;
use feature 'say';
use List::Util qw/reduce all/;

my @N = @ARGV;

die '@N must contain positive integers only' unless all { $_ =~ qr/^[1-9]\d*$/ } @N;

my $product = reduce { $a * $b } @N;

my @M = map { $product / $_ } @N;

say '(', join(', ', @M), ')';
