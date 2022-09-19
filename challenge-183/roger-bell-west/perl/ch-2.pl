#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

use DateTime;
use DateTime::Format::Strptime;

is_deeply(datedifference('2019-02-10', '2022-11-01'), [3, 264], 'example 1');
is_deeply(datedifference('2020-09-15', '2022-03-29'), [1, 195], 'example 2');

sub datedifference($d1s, $d2s) {
  my $strp = DateTime::Format::Strptime->new(
    pattern   => '%Y-%m-%d',
    strict => 1,
    time_zone => 'GMT',
      );
  my $d1=$strp->parse_datetime($d1s);
  my $d2=$strp->parse_datetime($d2s);
  if ($d1 > $d2) {
    ($d2, $d1) = ($d1, $d2);
  }
  my $yd = $d2->year - $d1->year;
  my $inter = DateTime->new(year => $d2->year,
                            month => $d1->month,
                            day => $d1->day);
  if ($d1->month > $d2->month ||
      ($d1->month == $d2->month && $d1->day > $d2->day)) {
    $inter = DateTime->new(year => $d2->year-1,
                           month => $d1->month,
                           day => $d1->day);
    $yd--;
  }
  return [$yd, $d2->delta_days($inter)->in_units('days')];
}
