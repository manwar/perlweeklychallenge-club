#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 1;

use DateTime;

is_deeply(lastsunday(2022),
          [ '2022-01-30', '2022-02-27', '2022-03-27', '2022-04-24',
            '2022-05-29', '2022-06-26', '2022-07-31', '2022-08-28',
            '2022-09-25', '2022-10-30', '2022-11-27', '2022-12-25' ],
          'example 1');

sub lastsunday($year) {
  my @o;
  foreach my $month (1..12) {
    my $dt = DateTime->last_day_of_month(year => $year,
                                         month => $month);
    my $dl = $dt->day_of_week();
    if ($dl != 7) {
      $dt->subtract(days => $dl);
    }
    push @o,$dt->strftime('%Y-%m-%d');
  }
  return \@o;
}
