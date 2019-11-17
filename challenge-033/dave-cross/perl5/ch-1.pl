#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my %letters;

while (<>) {
  $_ = lc $_;
  tr/a-z//cd;

  $letters{$_}++ for split //;
}

say "$_: $letters{$_}" for sort keys %letters;
