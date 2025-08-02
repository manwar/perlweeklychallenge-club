#!/usr/bin/env perl
use v5.40;
use DateTime;

my ($year, $month, $day) = split '-', shift @ARGV;

my $dt = DateTime->new(
                       year  => $year,
                       month => $month,
                       day   => $day,
                      );

say $dt->day_of_year;
