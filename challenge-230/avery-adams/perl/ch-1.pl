#!/usr/bin/perl
use v5.36;

my @nums;
push(@nums, split(//, $_)) for @ARGV;
say $_ for @nums;
