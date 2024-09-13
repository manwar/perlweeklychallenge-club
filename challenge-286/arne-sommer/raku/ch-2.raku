#! /usr/bin/env raku

my $powtwo := (1, 2, 4, 8 ... *);

unit sub MAIN (*@ints where all(@ints) ~~ Int && @ints.elems > 0,
               :v(:$verbose));

my $length = @ints.elems;

for $powtwo -> $int
{
  last if $int == $length;
  die 'Wrong number of @ints. Should be power of two' if $int > $length;
}

while @ints.elems > 1
{
  say ":\@ints: ({ @ints.join(",") })" if $verbose;

  my @new;
  my $min = True;

  for @ints -> $first, $second
  {
    @new.push($min ?? min($first, $second) !! max($first, $second) );

    $min = ! $min;
  }

  @ints = @new;
}

say @ints.first;
