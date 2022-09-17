#!/usr/bin/perl
use List::Util 'max'; use List::MoreUtils 'firstidx'; use warnings; use strict; use v5.10;

my $max = max(@ARGV);

say firstidx { $_ == $max } @ARGV;
