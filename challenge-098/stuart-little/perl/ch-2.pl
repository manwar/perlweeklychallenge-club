#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <target> <space-separated array entries>

use feature qw(signatures);
no warnings qw(experimental::signatures);

say scalar(grep {$_ < $ARGV[0]} @ARGV[1..$#ARGV]);
