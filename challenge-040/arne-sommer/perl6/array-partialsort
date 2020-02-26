#! /usr/bin/env raku

sub MAIN (:$verbose, :$list = "10 4 1 8 12 3", :$sort = "0 2 5")
{
  my @array   = $list.words>>.Numeric;
  my @indeces = $sort.words;

  if $verbose
  {
    say ":A: @array[]";
    say ":I: @indeces[]";
    say ":O: @array[@indeces]";
    say ":R: { @array[@indeces].=sort }";
  }
  else
  {
    @array[@indeces].=sort;
  }

  say @array;
}
