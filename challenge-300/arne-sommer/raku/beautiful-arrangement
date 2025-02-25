#! /usr/bin/env raku

subset PosInt of Int where * > 0;

unit sub MAIN (PosInt $int, :v(:$verbose));

my $count = 0;

PERM: for (1 .. $int).permutations -> @perm
{
  for 1 .. $int -> $index
  {
    unless @perm[$index -1] %% $index || $index %% @perm[$index -1]
    {
      say ":   Not beautiful: ({ @perm.join(",") })" if $verbose;
      next PERM;
    }
  }

  $count++;
  say ": + Beatutiful #$count: ({ @perm.join(",") })" if $verbose;
}

say $count;