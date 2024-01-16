#! /usr/bin/env raku

unit sub MAIN (Str $matrix = "1 2 3 4 | 5 6 7 8 | 9 10 11 12", :v(:$verbose));

my @a    = $matrix.split("|")>>.words>>.Int>>.Array;
my $rows = @a.elems;
my $cols = @a[0].elems;

die "The rows must have the same size" unless [==] @a>>.elems;
die "Integers only" unless all(@a[*;*]) ~~ Int;

say ": Matrix: { @a.raku }" if $verbose;

my @b;

for 0 .. $rows -2 -> $r
{
  for 0 .. $cols -2 -> $c
  {
    @b[$r][$c] = @a[$r][$c] + @a[$r][$c+1] + @a[$r+1][$c] + @a[$r+1][$c+1];
  }
}

say "[";
@b.map({ say "  [" ~ @_>>.join(", ") ~ "]" });
say "]";
