#!/usr/bin/env perl
use 5.012;
use warnings;

use Time::Piece;

my $t = Time::Piece->strptime('2019-12-25', '%F');

until ($t->year > 2100) {
  say $t->ymd if $t->day eq 'Sun';
  $t = $t->add_years(1);
}
