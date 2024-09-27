#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ UInt, :v(:$verbose));

my $lower  = $str;
my $higher = $str;

loop
{
  $lower -= 1;

  if $lower >= 0
  {
    say ": Down: $lower (distance { $str - $lower })" if $verbose;

    if $lower.flip eq $lower
    {
      say $lower;
      last;
    }
  }

  $higher += 1;

  say ": Up:   $higher (distance { $higher - $str })" if $verbose;

  if $higher.flip eq $higher
  {
    say $higher;
    last;
  }
}
