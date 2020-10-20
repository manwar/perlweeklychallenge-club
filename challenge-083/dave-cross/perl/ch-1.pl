#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

$_ = join ' ', @ARGV;

unless (defined and /\S+\s+\S+\s+\S+/) {
  die "Your string must include three words\n";
}

s/^\s*\S+\s+//;
s/\s+\S+\s*$//;
s/\s+//g;

say length;
