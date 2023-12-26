#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems %% 2 && @ints.elems > 0 && all(@ints) ~~ Int, :v(:$verbose));

my @output;
my @sorted = @ints>>.Int.sort;

say ":Sorted: { @sorted.join(",") }" if $verbose;

while @sorted
{
  my $first  = @sorted.shift;
  my $second = @sorted.shift;

  if $first == $second
  {
    @output.push: ($first, $second);
    say ":Pair: $first,$second" if $verbose;
  }
  else
  {
    say ":Non-pair: $first,$second" if $verbose;
    say "()";
    exit;
  }
}

say @output.map({ "($_[0], $_[1])"}).join(", ");
