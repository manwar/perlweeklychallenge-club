#!/usr/bin/perl
#run like: perl ch-1.pl 4 2 3 1 5 0
use List::Util 'max'; use List::MoreUtils 'firstidx'; use warnings; use strict; use v5.10;

my $max = max(@ARGV);

say firstidx { $_ == $max } @ARGV;
