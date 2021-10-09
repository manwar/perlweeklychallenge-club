#!/usr/bin/env perl

use 5.034;
use warnings;
use DateTime;

my ($year, $month, $day) = split /\//, $ARGV[0];

my $dt_now = DateTime->now();
my $dt_in  = DateTime->new(
  year  => $year,
  month => $month,
  day   => $day,
);

my $diff = $dt_now->delta_days($dt_in);

my $older   = $dt_in->subtract($diff)->ymd;
my $younger = $dt_now->add($diff)->ymd;

say join ', ', $older, $younger;
print "\n";
say 'On the date you were born, someone who was your current age, would have been born on ' . $older;
say 'Someone born today will be your current age on ' . $younger;
