#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(formatdate('1st Jan 2025'), '2025-01-01', 'example 1');
is(formatdate('22nd Feb 2025'), '2025-02-22', 'example 2');
is(formatdate('15th Apr 2025'), '2025-04-15', 'example 3');
is(formatdate('23rd Oct 2025'), '2025-10-23', 'example 4');
is(formatdate('31st Dec 2025'), '2025-12-31', 'example 5');

sub formatdate($a) {
  $a =~ /^([0-9]+)[a-z]+ ([A-Z][a-z]{2}) ([0-9]+)/;
  my @dmy = ($3, $2, $1);
  $dmy[1] = {
    "Jan" => 1,
    "Feb" => 2,
    "Mar" => 3,
    "Apr" => 4,
    "May" => 5,
    "Jun" => 6,
    "Jul" => 7,
    "Aug" => 8,
    "Sep" => 9,
    "Oct" => 10,
    "Nov" => 11,
    "Dec" => 12,
  }->{$dmy[1]};
  sprintf('%04d-%02d-%02d', @dmy);
}
