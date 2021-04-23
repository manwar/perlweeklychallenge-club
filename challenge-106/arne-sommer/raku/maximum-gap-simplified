#! /usr/bin/env raku

multi sub MAIN (*@N where @N.elems == 1, :v($verbose))
{
  say 0;
}

multi sub MAIN (*@N where @N.elems > 1 && all(@N) ~~ Int, :v($verbose))
{
  my @diffs = diff-pairs(@N.sort, $verbose);

  say @diffs.max;
}

sub diff-pairs (@list is copy, $verbose)
{
  my $first = @list.shift;
  my $second;
  my @result;

  while (@list)
  {
    $second = @list.shift;

    @result.push: abs($first - $second);

    say ": Added diff from Pair: $first,$second -> { abs($first - $second) }" if $verbose;

    $first = $second;
  }

  return @result;
}
