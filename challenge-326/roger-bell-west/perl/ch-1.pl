#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(dayoftheyear('2025-02-02'), 33, 'example 1');
is(dayoftheyear('2025-04-10'), 100, 'example 2');
is(dayoftheyear('2025-09-07'), 250, 'example 3');

use DateTime;
use DateTime::Format::Strptime;

sub dayoftheyear($a) {
  my $strp = DateTime::Format::Strptime->new(
    pattern   => '%Y-%m-%d',
    strict => 1,
    time_zone => 'GMT',
      );
    $strp->parse_datetime($a)->day_of_year;
}
