#!/bin/perl

=pod

The Weekly Challenge - 183
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-183/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Date Difference
Submitted by: Mohammad S Anwar

You are given two dates, $date1 and $date2 in the format YYYY-MM-DD.

Write a script to find the difference between the given dates in terms on years and days only.

=cut

use v5.16;
use warnings;

use Test::More;
use Test::Deep;
use Data::Printer output => 'stdout';

use DateTime;
use DateTime::Duration;


sub dateToHash($) {
  return {year => $1, month => $2, day => $3}
    if ($_[0] =~ /^(\d+)-(\d+)-(\d+)$/);
}

sub dateDifference($$) {
  my ($f,$t) = map { DateTime->new(dateToHash $_) } sort @_;

  my $y = $t->subtract_datetime($f)->in_units('years');
  $f += DateTime::Duration->new(years => $y);

  return [$y, $f->delta_days($t)->{days}];
}

my @d = (
  ['2019-02-10','2022-11-01',[3,264]],
  ['2020-09-15','2022-03-29',[1,195]],
  ['2019-12-31','2020-01-01',[0,1]],
  ['2019-12-01','2019-12-31',[0,30]],
  ['2019-12-31','2020-12-31',[1,0]],
  ['2019-12-31','2021-12-31',[2,0]],
  ['2020-09-15','2021-09-16',[1,1]],
  ['2019-09-15','2021-09-16',[2,1]],
);

foreach my $c (@d) {
  cmp_deeply(dateDifference($$c[0],$$c[1]),$c->[2]);
  cmp_deeply(dateDifference($$c[1],$$c[0]),$c->[2]);
}

done_testing;
