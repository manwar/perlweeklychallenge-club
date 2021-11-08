#!/usr/bin/perl

use strict;
use warnings;

my $N = $ARGV[0];
die "ERROR: Missing input number.\n" unless defined $N;
die "ERROR: Invalid input number [$N].\n" if ($N < 0);

my $n = 0;
my $i = 0;
while (1) { $n++; next if (($n =~ /11/) || ($n =~ /[4567890]/)); $i++; last if ($i == $N); }
print "$n\n";
