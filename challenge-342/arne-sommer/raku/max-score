#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^ <[01]> ** 2..* $/,
               :v(:$verbose));

my $max = -Inf;

for 1 .. $str.chars -1 -> $i
{
  my $left        = $str.substr(0, $i);
  my $right       = $str.substr($i);
  my $left-score  = $left.comb.grep( * eq 0 ).elems;
  my $right-score = $right.comb.sum;
  my $score       = $left-score + $right-score;

  say ": Index:$i: $left - $right | $left-score + $right-score = $score { $score > $max ?? "max" !! ""}" if $verbose;

  $max = $score if $score > $max;
}

say $max;
