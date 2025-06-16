#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;

sub day_of_the_year{
  Time::Piece->strptime($_[0],'%Y-%m-%d')->yday + 1
}

printf "%d\n",day_of_the_year('2025-02-02');
printf "%d\n",day_of_the_year('2025-04-10');
printf "%d\n",day_of_the_year('2025-09-07');

