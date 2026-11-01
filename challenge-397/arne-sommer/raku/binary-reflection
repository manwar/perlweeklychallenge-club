#! /usr/bin/env raku

unit sub MAIN (*@arr where @arr.elems > 0 && all(@arr) ~~ UInt,
               :v(:$verbose));

my @result = @arr.sort: { reflect($_), $_ };

if $verbose
{
  for @arr -> $n
  {
    my $bin = $n.base(2);
    say ": $n -> $bin -> { $bin.comb.reverse.join } -> { reflect($n) }";
  }
}

say "({ @result.join(", ") })";

sub reflect(Int $n)
{
  $n.base(2).flip.join.parse-base(2);
}
