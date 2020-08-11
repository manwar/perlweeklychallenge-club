#! /usr/bin/env perl6

my %seen;

for (1 .. 10, 1..10, 1..10).flat.combinations(3).unique(:with(&[eqv])).grep(*.sum == 12)
{
  my @sorted = $_.sort;

  next if %seen{@sorted.Str};
  say @sorted;
  %seen{@sorted.Str} = True;
}
