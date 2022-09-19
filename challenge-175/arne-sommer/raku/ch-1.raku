#! /usr/bin/env raku

unit sub MAIN (Int $year = Date.today.year);

for 1 .. 12 -> $month
{
  my $date = Date.new($year, $month, Date.new($year, $month, 1).days-in-month);

  $date.=pred while $date.day-of-week != 7;

  say $date;
}
