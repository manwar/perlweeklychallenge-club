#!/usr/bin/env perl

use v5.16;
use strict;
use warnings;

die("Provide (only) stones and jewels") unless @ARGV == 2;

my (%hash) = map { $_, 1 } split //, $ARGV[0];
my (@matches) = grep { exists $hash{$_} } split //, $ARGV[1];
say scalar(@matches);

