#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int && @ints.elems > 1,
               :f(:$fast-fail),
               :v(:$verbose));

my @a = @ints>>.Int;

if $fast-fail && [>=] @a { say -1; exit }

my $end = @a.end;

for $end ... 1 -> $i
{
  for $i -1 ... 0 -> $j
  {
    if @a[$i] > @a[$j]
    {
      say ": index:$i -> @a[$i], index:$j -> @a[$j] (swap)" if $verbose;
      my $n = @a[$i];
      @a[$i] = @a[$j];
      @a[$j] = $n;

      @a[$j+1 .. *] = @a[$j+1 .. *].sort if $i > $j +1;

      say "({ @a.join(", ") })";
      exit;
    }
    elsif $verbose
    {
      say ": index:$i -> @a[$i], index:$j -> @a[$j] (skip)" if $verbose;
    }
  }
}

say "-1";
