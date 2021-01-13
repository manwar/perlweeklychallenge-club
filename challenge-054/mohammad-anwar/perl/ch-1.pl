#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(reduce);
use Algorithm::Combinatorics qw(permutations);

my $n = $ARGV[0];
my $k = $ARGV[1];

die "ERROR: Missing digit count.\n"        unless defined $n;
die "ERROR: Missing sequence number.\n"    unless defined $k;
die "ERROR: Invalid digit count $n.\n"     unless $n > 0;
die "ERROR: Invalid sequence number $k.\n" unless $k > 0 && ($k <= reduce { $a * $b } 1 .. $n);

print [ map { join "", @$_ } permutations([ 1..$n ]) ]->[$k-1];
