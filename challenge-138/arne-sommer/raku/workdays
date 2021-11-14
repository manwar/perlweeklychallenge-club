#! /usr/bin/env raku

unit sub MAIN (Int $year where $year.chars == 4);

my $d         = Date.new("$year-01-01");
my $first-day = $d.day-of-week;

my @workdaysinyear =
(
  0,   # dummy
  261, # Monday    - Monday
  261, # Tuesday   - Tuesday
  261, # Wednesday - wednesday
  261, # Thursday  - Thursday
  261, # Friday    - Friday
  260, # Saturday  - Saturday
  259, # Sunday    - Sunday
);

my @add-leap =
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

my $count = @workdaysinyear[$first-day] + ($d.is-leap-year ?? @add-leap[$first-day] !! 0);

say $count;

