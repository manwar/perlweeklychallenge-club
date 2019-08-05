#! /usr/bin/env perl6

unit sub MAIN (Int $year = DateTime.now.year);

for 1 .. 12 -> $month
{
  my $date = Date.new($year, $month, Date.new($year, $month, 1).days-in-month);

  $date.=pred while $date.day-of-week != 5;

  say $date.Str.trans("-" => "/");
}
