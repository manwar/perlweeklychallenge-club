#!/usr/bin/perl

use strict;
use warnings;
use DateTime;

sub friday_13ths {
  my ($year) = @_;

  my $dt = DateTime->new(
    year => $year,
    month => 1,
    day => 1
  );

  my $friday_13_count = 0;

  while ($dt->year == $year) {
    if ($dt->day_of_week == 5 && $dt->day == 13) {
      $friday_13_count++;
    }
    $dt->add(days => 1);
  }

  return $friday_13_count;
}

print friday_13ths(2023), "\n"; # 2
