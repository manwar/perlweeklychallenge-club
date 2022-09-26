#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use Data::Dumper;

die "No input\n" if !@ARGV;

for (@ARGV) {
  die "Invalid input $_\n" if /[^a-z0-9 ]/;
}

my ($digits, $alpha);

for (@ARGV) {
  push @$digits, [ grep { /[0-9]/ } split ];
  push @$alpha,  [ grep { /[a-z]/ } split ];
}

say Dumper [ grep { @$_ } @$digits ];
say Dumper [ grep { @$_ } @$alpha ];

