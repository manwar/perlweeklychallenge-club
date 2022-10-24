#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use DateTime;
use DateTime::Format::Strptime;

use Test::More tests => 4;

is_deeply(daystogether(["12-01", "20-01"], ["15-01", "18-01"]),
          4,
          'example 1');

is_deeply(daystogether(["02-03", "12-03"], ["13-03", "14-03"]),
          0,
          'example 2');

is_deeply(daystogether(["02-03", "12-03"], ["11-03", "15-03"]),
          2,
          'example 3');

is_deeply(daystogether(["30-03", "05-04"], ["28-03", "02-04"]),
          4,
          'example 4');

sub daystogether($a,$b) {
    my @starts = sort (s2date($a->[0]), s2date($b->[0]));
    my @ends = sort (s2date($a->[1]), s2date($b->[1]));
    if ($ends[0] > $starts[1]) {
        return $ends[0]->delta_days($starts[1])->in_units('days')+1;
    } else {
        return 0;
    }
}

sub s2date($ds) {
  my $strp = DateTime::Format::Strptime->new(
    pattern   => '%d-%m-%Y',
    strict => 1,
    time_zone => 'GMT',
      );
  return $strp->parse_datetime("$ds-2022");
}
