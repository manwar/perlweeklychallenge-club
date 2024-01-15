#! /usr/bin/env raku

unit sub MAIN (Str $matrix = "3 7 8 | 9 11 13 | 15 16 17", :v(:$verbose));

my @a    = $matrix.split("|")>>.words>>.Int>>.Array;
my $rows = @a.elems;
my $cols = @a[0].elems;

my @values = @a[*;*];

die "The rows must have the same size" unless [==] @a>>.elems;
die "Integers only" unless all(@values) ~~ Int;
die "Unique values only" unless @values.elems == @values.unique.elems;

say ":Matrix: { @a.raku }" if $verbose;

for 0 .. $rows -1 -> $row
{
  my @row = |@a[$row];
  my ($col, $min) = @row.minpairs.first.kv;

  say ":Row[$row]: { @row.join(",") } - lowest:$min (at column:$col)" if $verbose;

  my @col = @a[*;$col];
  my $max = @col.max;

  say ":- Col[$col]: { @col.join(",") } - highest:$max" if $verbose;

  if $max == $min
  {
    say $max;
    exit;
  }
}

say "-1";
