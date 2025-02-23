#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int && ( [<] @ints ) && @ints.elems > 1,
               :v(:$verbose));

my $left    = @ints.shift;
my $min-gap = Inf;
my $at      = Inf;

while (@ints.elems)
{
  my $right       = @ints.shift;
  my $gap         = $right - $left;
  my $is-smallest = $gap < $min-gap;
     $min-gap     = $gap if $is-smallest;
     $at          = $right if $is-smallest;

  say ": $right - $left => $gap { $is-smallest ?? "(smallest)" !! ""}" if $verbose;

  $left = $right;
}

say $at;
