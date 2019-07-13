#! /usr/bin/env perl6

my $pythagoras-pie := gather
{
  my $remainder = 100;
  my $position  = 1;
  loop
  {
    my $part = $remainder * $position / 100;
    $remainder -= $part;
    $position++;
    take $part;
  }
}

my $largest = $pythagoras-pie[^100].max;

for (^100).grep({ $pythagoras-pie[$_] == $largest }) -> $guest
{
  say "Guest #{ $guest + 1 } got the largest piece of cake ({ $largest }%).";
}

