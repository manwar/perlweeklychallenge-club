#! /usr/bin/env perl6

unit sub MAIN (UInt :$from = 2019, UInt :$to = 2100);

for $from ... $to -> $year
{
  say "25 Dec $year is Sunday." if Date.new($year, 12, 25).day-of-week == 7;
}
