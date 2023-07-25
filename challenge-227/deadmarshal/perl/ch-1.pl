#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;

sub friday_13th{
  my ($count,$year) = (0,@_);
  foreach my $month(1..12){
    my $d = Time::Piece->strptime("$year-$month-13", "%Y-%m-%d");
    $count++ if $d->day_of_week == 5;
  }
  $count
}

printf "%d\n", friday_13th(2023);

