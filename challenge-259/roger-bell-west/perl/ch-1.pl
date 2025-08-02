#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(bankingdayoffset('2018-06-28', 3, ['2018-07-03']), '2018-07-04', 'example 1');
is(bankingdayoffset('2018-06-28', 3, []), '2018-07-03', 'example 2');

use DateTime;
use DateTime::Format::Strptime;

sub bankingdayoffset($start, $offset, $bankholidays) {
  my $strp = DateTime::Format::Strptime->new(
    pattern   => '%Y-%m-%d',
    strict => 1,
    time_zone => 'GMT',
      );
  my %bh = map {$strp->parse_datetime($_) => 1} @{$bankholidays};
  my $current = $strp->parse_datetime($start);
  foreach (1 .. $offset) {
    $current = $current->add(days => 1);
    while (exists $bh{$current} || $current->day_of_week > 5) {
      $current = $current->add(days => 1);
    }
  }
  return $current->strftime('%Y-%m-%d');
}
