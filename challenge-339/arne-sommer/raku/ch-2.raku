#! /usr/bin/env raku

unit sub MAIN (*@gain where @gain.elems >= 1 && all(@gain) ~~ Int,
               :v(:$verbose));

my $max     = 0;
my $current = 0;

say ": Start at 0 (new max)" if $verbose;

for @gain -> $change
{
  print ": $current + $change = { $current + $change }" if $verbose;

  $current += $change;

  if ($current > $max)
  {
    say " (new max)" if $verbose;

    $max = $current;
  }
  elsif $verbose
  {
    say '';
  }
}

say $max;
