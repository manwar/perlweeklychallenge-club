#!/usr/bin/perl

use strict;
use warnings;

my $T = $ARGV[0];
die "ERROR: Missing time.\n" unless defined $T;
die "ERROR: Invalid time [$T].\n" unless ($T =~ /^\d\d\:\d\d$/);

my ($hh, $mi) = split /\:/, $T, 2;

# Formula borrowed from Wikipedia page.
# https://en.wikipedia.org/wiki/Clock_angle_problem
my $a = 0.5 * (60 * $hh - 11 * $mi);

$a = 360 - $a if ($a > 180);
print "$a\n";
