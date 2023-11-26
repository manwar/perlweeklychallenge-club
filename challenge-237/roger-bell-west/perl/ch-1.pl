#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(seizetheday(2024, 4, 3, 2), 16, 'example 1');
is(seizetheday(2025, 10, 2, 4), 9, 'example 2');
is(seizetheday(2026, 8, 5, 3), 0, 'example 3');

use DateTime;

sub seizetheday($year, $month, $weekcount, $dayofweek) {
  my $dt = DateTime->new(year => $year,
                         month => $month,
                         day => 1,
                         hour => 12,
                         minute => 0,
                         second => 0);
  my $wd = $dt->day_of_week();
  if ($wd != $dayofweek) {
    $dt = $dt->add(days => ($dayofweek - $wd + 7) % 7);
  }
  if ($weekcount > 1) {
    $dt = $dt->add(days => 7 * ($weekcount - 1));
  }
  if ($dt->month != $month || $dt->year != $year) {
    return 0;
  }
  return $dt->day;
}
