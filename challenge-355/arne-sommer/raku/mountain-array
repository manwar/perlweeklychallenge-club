#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems >= 3 && all(@ints) ~~ Int,
               :a(:$show-all),
               :v(:$verbose) = $show-all);

my $is-ok = False;

for 1 .. @ints.end -1 -> $i
{
  my @left  = @ints[0..$i];
  my @right = @ints[$i..*];
  my $ok    = ( [<] @left ) && ( [>] @right );

  say ": i:$i : @left[] <-> @right[] = $ok" if $verbose;

  if $ok
  {
    $is-ok = True;
    last unless $show-all;
  }
}

say $is-ok;
