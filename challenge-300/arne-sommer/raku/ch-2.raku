#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int,
               :v(:$verbose));

die "Duplicates"   unless [<] @ints.sort;
die "Missing zero" unless @ints.min == 0;
die "Missing n"    unless @ints.max == @ints.elems -1;

my @set = 0,;

loop
{
  my $index = @set.tail;
  my $value = @ints[$index];

  last if $value eq any(@set);

  @set.push: @ints[$index];

  say ": @set[]" if $verbose;
}

say @set.elems;
