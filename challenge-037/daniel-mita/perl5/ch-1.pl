#!/usr/bin/env perl

use v5.30;
use warnings;

use List::Util qw<all>;
use Time::Piece;
use Time::Seconds;

my %count;
my $d = Time::Piece->strptime( 2019, '%Y' );

while ( $d->year == 2019 ) {
  $count{$d->month}++ if all { $d->day ne $_ } qw<Sat Sun>;
  $d += ONE_DAY;
}

say "$_: $count{$_}" for Time::Piece::mon_list;
