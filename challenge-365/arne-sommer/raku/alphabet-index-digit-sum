#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^ <[a..z]>+ $/,
               UInt $k where $k > 0,
               :v(:$verbose));

my @digits = $str.comb.map({ $_.ord - 'a'.ord + 1 });
my $sum    = @digits.join;

say ": Digits: { @digits.join(", ") } -> $sum" if $verbose;

for 1 .. $k -> $iteration
{
  @digits = $sum.comb;
  $sum    = @digits.sum;

  say ": Iteration $iteration: { @digits.join(" + ") } = $sum" if $verbose;

  last if $sum < 10;
}

say $sum;
