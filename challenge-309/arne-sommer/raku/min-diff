#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ UInt && @ints.elems > 1,
               :v(:$verbose));

my @sorted = @ints.sort;

my $left     = @sorted.shift;
my $min-diff = Inf;

while (@sorted.elems)
{
  my $right       = @sorted.shift;
  my $diff        = $right - $left;
  my $is-smallest = $diff < $min-diff;
     $min-diff    = $diff if $is-smallest;

  say ": $right - $left => $diff { $is-smallest ?? "(smallest)" !! ""}" if $verbose;

  $left = $right;
}

say $min-diff;
