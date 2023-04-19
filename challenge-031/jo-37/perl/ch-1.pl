#!/usr/bin/perl

use v5.16;
use warnings;

my $div = eval {$ARGV[0] / $ARGV[1]};
say $@ ? $@ : $div;
say "done.";
