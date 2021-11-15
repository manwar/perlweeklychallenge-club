#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use DateTime;

my $year = shift(@ARGV) // "";

die "Please specify a 4 digit year" unless $year =~ /^\d\d\d\d$/;

my $dt        = DateTime->new(year => $year, month => 1, day => 1);
my $first_day = $dt->day_of_week;

my @workdaysinyear =
(
  0,   # dummy   # 52 * 7 = 364 | 52 * 5 = 260
  261, # Monday    - Monday
  261, # Tuesday   - Tuesday
  261, # Wednesday - wednesday
  261, # Thursday  - Thursday
  261, # Friday    - Friday
  260, # Saturday  - Saturday
  259, # Sunday    - Sunday
);

my @add_leap =
(
  0, # Dummy
  1, # Mo -> Tu
  1, # Tu -> We
  1, # We -> Th
  1, # Th -> Fr
  0, # Fr -> Sa
  0, # Sa -> Su
  1, # Su -> Ma
);

my $count = $workdaysinyear[$first_day] + ($dt->is_leap_year ? $add_leap[$first_day] : 0);

say $count;
