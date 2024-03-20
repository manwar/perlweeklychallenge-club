#! /usr/bin/env raku

unit sub MAIN (Int $start is copy,
               *@ints where all(@ints) ~~ Int && @ints.elems > 0,
               :v(:$verbose));

my $step = 1;

while any(@ints) == $start
{
  say ": Step { $step++ }: $start is in the array, so $start x 2 = { $start * 2 }" if $verbose;
  $start =  $start * 2;
}

say ": $start is not found in the array, so return $start" if $verbose;

say $start;
