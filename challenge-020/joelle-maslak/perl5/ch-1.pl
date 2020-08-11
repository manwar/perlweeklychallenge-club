#!/usr/bin/env perl

use strict;
use warnings;

use v5.22;

die "Must provide character string" if scalar(@ARGV) != 1;

my (@parts) = grep { state $i=1; $i++ % 2 } $ARGV[0] =~ /((.)\2*)/gms;
say join("\n", @parts);

