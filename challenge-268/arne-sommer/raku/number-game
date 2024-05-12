#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && @ints.elems %% 2 && all(@ints) ~~ Int, :v(:$verbose));

my @sorted = @ints.sort;
my @new;

while @sorted
{
  print ":Sorted: { @sorted.join(",")}" if $verbose;

  my $a = @sorted.shift;
  my $b = @sorted.shift;

  say " -> pick $a,$b -> add $b,$a" if $verbose;

  @new.append: $b, $a;
}

say "({ @new.join(", ") })";
