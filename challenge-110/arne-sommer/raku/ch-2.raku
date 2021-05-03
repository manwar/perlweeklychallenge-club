#! /usr/bin/env raku

unit sub MAIN ($csv-file where $csv-file.IO.f && $csv-file.IO.r = 'persons.csv');

my @lines;

for $csv-file.IO.lines -> $line
{
  my @words = $line.split(',');

  for 0 .. @words.end -> $index
  {
     @lines[$index].push: @words[$index];
  }
}

for @lines -> $line
{
  say $line.join(',');
}
