#!/usr/bin/env perl

use Modern::Perl;
use List::Util 'sum';

my @ints = @ARGV;
my @digits = split //, join '', @ints;
say abs(sum(@ints) - sum(@digits));
