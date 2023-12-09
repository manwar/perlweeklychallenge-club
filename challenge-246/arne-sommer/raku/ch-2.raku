#! /usr/bin/env raku

unit sub MAIN (*@a where @a.elems == 5 && all(@a) ~~ Int, :v(:$verbose));

for -10 .. 10 -> $p
{
  for -10 .. 10 -> $q
  {
    is-lroso(@a, $p, $q) if $p * @a[0] + $q * @a[1] == @a[2];
  }
}

say 'false';

sub is-lroso (@a is copy, $p, $q)
{
  my $first  = @a.shift;
  my $second = @a.shift;
  my $target;

  while (@a.elems)
  {
    $target = @a.shift;
    return unless $p * $first + $q * $second == $target;

    $first  = $second;
    $second = $target;
  }

  say ": p:$p, q:$q" if $verbose;
  say 'true';
  exit;
}
