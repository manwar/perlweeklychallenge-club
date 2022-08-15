#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 6;

use DateTime;
use DateTime::Format::Strptime;

is(addbizhours("2022-08-01 10:30",   4), "2022-08-01 14:30", 'example 1');
is(addbizhours("2022-08-01 17:00", 3.5), "2022-08-02 11:30", 'example 2');
is(addbizhours("2022-08-01 18:00", 3.5), "2022-08-02 12:30", 'example 3');
is(addbizhours("2022-08-01 19:00", 3.5), "2022-08-02 12:30", 'example 4');
is(addbizhours("2022-08-05 17:00", 3.5), "2022-08-08 11:30", 'example 5');
is(addbizhours("2022-08-01 12:00",  18), "2022-08-03 12:00", 'example 6');

sub addbizhours($start, $delta) {
  my $strp = DateTime::Format::Strptime->new(
    pattern   => '%Y-%m-%d %H:%M',
    strict => 1,
    time_zone => 'GMT',
      );
  my $current=$strp->parse_datetime($start);
  my $seconds = 3600 * $delta;
  my $bizdaylength = 3600 * 9;
  unless (isbiz($current)) {
    $current = nextbizstart($current);
  }
  my $ed = nextbizend($current);
  my $remain = ($ed->subtract_datetime_absolute($current))->in_units('seconds');
  if ($remain < $seconds) {
    $seconds -= $remain;
    $current = nextbizstart($ed);
    while ($seconds > $bizdaylength) {
      $current = nextbizstart($current);
      $seconds -= $bizdaylength;
    }
  }
  $current->add(seconds => $seconds);
  return $current->strftime('%Y-%m-%d %H:%M');
}

sub isbiz($tm) {
  if ($tm->day_of_week > 5) {
    return 0;
  }
  if ($tm->hour < 9 || $tm->hour >= 18) {
    return 0;
  }
  return 1;
}

sub nextbizstart($tm0) {
  my $tm = $tm0->clone;
  while ($tm->day_of_week > 5) {
    $tm = $tm->add(days => 1)->set(hour => 9, minute => 0, second => 0);
  }
  if ($tm->hour < 9) {
    $tm->set(hour => 9, minute => 0, second => 0);
  } else {
    while (1) {
      $tm = $tm->add(days => 1)->set(hour => 9, minute => 0, second => 0);
      if ($tm->day_of_week <= 5) {
        last;
      }
    }
  }
  return $tm;
}

sub nextbizend($tm0) {
  my $tm = $tm0->clone;
  while ($tm->day_of_week > 5) {
    $tm = $tm->add(days => 1)->set(hour => 18, minute => 0, second => 0);
  }
  if ($tm->hour >= 18) {
    while (1) {
      $tm = $tm->add(days => 1)->set(hour => 18, minute => 0, second => 0);
      if ($tm->day_of_week <= 5) {
        last;
      }
    }
  } else {
    $tm->set(hour => 18, minute => 0, second => 0);
  }
  return $tm;
}
