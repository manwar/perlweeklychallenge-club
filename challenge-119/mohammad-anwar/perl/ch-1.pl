#!/usr/bin/perl

use strict;
use warnings;

my $N = $ARGV[0];
die "ERROR: Missing input number.\n" unless defined $N;
die "ERROR: Input number should be > 0 but <= 255.\n" if ($N < 0 or $N > 255);

my $b = sprintf("%08d", sprintf("%b", $N));
print oct("0b". substr($b, 4) . substr($b, 0, 4)), "\n";
