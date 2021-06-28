#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use File::Slurp;
use List::Compare;

my $file = $ARGV[0] // die "Please specify a file";

my @ids = map { /^(\d+)\,/ } read_file($file, chomp => 1);
my @all = (1..15);

my $lc = List::Compare->new('--unsorted', \@ids, \@all);

my @difference = $lc->get_symmetric_difference();

say join(", ", @difference);

# Ubuntu/Debian: liblist-compare-perl
