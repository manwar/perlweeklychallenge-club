#! /usr/bin/env raku

unit sub MAIN (UInt $n where $n > 0, :v(:$verbose));

my $count = 0;

PERM: for (^$n).permutations -> @perm
{
  for ^$n -> $i
  {
    if @perm[$i] == $i
    {
      say ": [{ @perm.join(", ") }] -- (illegal)" if $verbose;
      next PERM;
    }
  }

  say ": [{ @perm.join(", ") }] ++ (legal)" if $verbose;

  $count++;
}

say $count;
