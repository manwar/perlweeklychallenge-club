#! /usr/bin/env raku

subset POSINT of Int where * > 0;

unit sub MAIN (POSINT :r(:$rows),
               POSINT :c(:$cols),
               *@ints where @ints.elems > 0 && all(@ints) ~~ Int,
               :v(:$verbose));

die "Wrong nymber of elems" unless @ints.elems == $rows * $cols;

my @matrix;

while @ints.elems
{
  my @row = @ints.splice(0,$cols)>>.Int;

  say ": Row: { @row.join(",") }" if $verbose;

  @matrix.push: @row;
}

say @matrix.raku;