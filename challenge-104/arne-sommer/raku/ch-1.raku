#! /usr/bin/env raku

unit sub MAIN ($limit = 50);

my $fusc := gather
{
  take 0; 
  take 1;
  my $index = 1;
  loop
  {
    $index++;
    take $fusc[$index / 2];
    $index++;
    take $fusc[($index - 1)/2] + $fusc[($index +1)/2];
  }
}

say $fusc[^$limit].join(", ");
