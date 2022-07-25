#!/usr/bin/perl
#
# Write a script to list Last Sunday of every month in the given year.

use strict;
use warnings;
use feature 'say';

use Time::Piece;
use Time::Seconds;

my $year = shift || localtime->year;

for (2 .. 13) {
  if ($_ == 13) {
    $year++;
    $_ = 1;
  }

  my $date_str = sprintf '%4d-%02d-01', $year, $_;
  my $date = Time::Piece->strptime($date_str, '%Y-%m-%d');

  $date -= ONE_DAY; # Last day of previous month
  # _wday() is 0 for Sun, 1 for Mon, etc...
  $date -= (ONE_DAY * $date->_wday);

  say $date->ymd;
}
