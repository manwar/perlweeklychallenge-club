#! /usr/bin/env raku

unit sub MAIN (Int $int is copy where $int > 0,
               :v(:$verbose));

my $persistence = 0;

while $int.chars > 1
{
  $persistence++;

  my $new = $int.comb.sum;

  say ": [$persistence] $int -> $new" if $verbose;

  $int = $new;
}

say "Persistence  = $persistence";
say "Digital Root = $int";
