#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

my $bin=sprintf("%b", $ARGV[0]);
say 0+($bin eq join "", reverse split("", $bin));
