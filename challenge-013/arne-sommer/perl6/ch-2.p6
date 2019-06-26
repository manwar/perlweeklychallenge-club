#! /usr/bin/env perl6

unit sub MAIN ($limit = 10);

my $M;
my $F := gather
{
  take 1;
  loop { state $index++; take $index - $M[$F[$index -1]]; }
}

$M := gather
{
  take 0;
  loop { state $index++; take $index - $F[$M[$index -1]]; }
}

say "  ", (    $_.fmt("%2d") for ^$limit ).join(" ");
say "F:", ( $F[$_].fmt("%2d") for ^$limit ).join(" ");
say "M:", ( $M[$_].fmt("%2d") for ^$limit ).join(" ");
