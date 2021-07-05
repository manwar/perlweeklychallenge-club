#!/usr/bin/perl

use strict;
use warnings;

my $N = $ARGV[0];
die "ERROR: Missing the input number.\n"     unless defined $N;
die "ERROR: Invalid number '$N' received.\n" if ($N < 0);

my $binary = sprintf("%b", $N);
print sprintf("%d\n", ($binary eq reverse $binary));
