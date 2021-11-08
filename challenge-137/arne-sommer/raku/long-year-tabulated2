#! /usr/bin/env raku

unit sub MAIN (Int :$lower = 1900, Int :$upper = 2100, :t(:$tabulated));

my @long-years;

for $lower .. $upper -> $year
{
  @long-years.push: $year if Date.new("$year-12-31").week-number == 53;
}

my $i = 1;

say $tabulated
  ?? @long-years.map({ ($i++ %% 5) ?? "$_,\n" !! "$_, " }).join.chop(2)
  !! @long-years.join(", ");
