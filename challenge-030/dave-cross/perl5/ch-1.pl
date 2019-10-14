#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use Time::Piece;

for (2019 .. 2100) {
  my $tp = Time::Piece->strptime($_ . '1225', '%Y%m%d');
  say $tp->strftime('%A %d %b %Y') if $tp->day eq 'Sun';
}
