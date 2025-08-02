#! /usr/bin/env raku

subset PosInt of Int where * > 0;

unit sub MAIN (*@ints is copy where @ints.elems > 0 && all(@ints) ~~ PosInt,
               :v(:$verbose));

my $n = @ints.elems;

say ": n:$n" if $verbose;

die "Duplicates"   unless [<] @ints.sort;
die "Missing zero" unless @ints.min == 1;
die "Missing n"    unless @ints.max == $n;

my $swaps = 0;
my $one-index = @ints.first(1, :k);

for (1 .. $one-index).reverse -> $index
{
  $swaps++;
  @ints[$index -1, $index] = @ints[$index, $index -1];

  say ": swap 1 #$swaps: index { $index - 1 } and $index -> ({@ints.join(",")})" if $verbose;
}

my $n-index = @ints.first($n, :k);

for $n-index .. $n -2 -> $index
{
  $swaps++;
  @ints[$index +1, $index] = @ints[$index, $index +1];

  say ": swap $n #$swaps: index { $index - 1 } and $index -> ({@ints.join(",")})" if $verbose;
}

say $swaps;
