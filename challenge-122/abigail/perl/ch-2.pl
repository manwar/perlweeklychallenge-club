#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

#
# Reads a single value from standard input
#

#
# $s [n] will contain the possible ways to get to a score of n - 2:
#
# $s [0] is empty, as there is no way to get to a score of -2
# $s [1] is empty, as there is no way to get to a score of -1
# $s [2] contains the empty string, as there is only one way to get
#        to a score of 0 (not scoring).
#
# To calculate $s [k], k > 2, we take the union of:
#
# The scores from $s [k - 1], prepended by "1";
# the scores from $s [k - 2], prepended by "2";
# the scores from $s [k - 3], prepended by "3";
#
# A triple nested map will do the trick.
#

my @s = ([], [], [""]);
map {push @s => [map {my $s = $_; map {"$s $_"} @{$s [-$s]}} 1 .. 3]} 1 .. <>;
say for @{$s [-1]}
