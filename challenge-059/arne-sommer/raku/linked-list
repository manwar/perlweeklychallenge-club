#! /usr/bin/env raku

multi MAIN (Int $k = 3, Str $list = "1 4 3 2 5 2", :$verbose)
{
  MAIN($k, $list.words, :$verbose);
}

multi MAIN (Int $k = 3, *@list, :$verbose)
{
  my @lower;
  my @higher;

  for @list -> $elem
  {
    $elem >= $k
      ?? @higher.push: $elem
      !! @lower.push: $elem;
  }

  my @result = (@lower, @higher).flat;

  if $verbose
  {
    say ": == : $k";
    say ": <  : @lower[]";
    say ": >= : @higher[]";
  }
  
  say @result.join(" → ");
}
  