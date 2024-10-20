#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int && @ints.elems > 0,
               :v(:$verbose));

@ints.unshift: 0;
@ints.push:    0;

for 1 .. @ints.elems - 2 -> $MI
{
  my @left  = @ints[0 .. $MI -1];
  my @right = @ints[$MI +1 .. *];

  my $left-sum  = @left.sum;
  my $right-sum = @right.sum;

  say ": MI:{ $MI -1 }: ({ @left[1..*].join(",")}) sum $left-sum <=> ({ @right[0..^*-1].join(",")}) sum $right-sum" if $verbose;

  if $left-sum == $right-sum
  {
    say $MI -1;
    exit;
  }
}

say -1;
