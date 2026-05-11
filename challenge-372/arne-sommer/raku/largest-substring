#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0,
               :v(:$verbose));

my @chars = $str.comb.Bag.grep({ .value > 1 })>>.key.sort;

say ":Duplicate characters (sorted): { @chars.map({ "«$_»" }).join(", ")}" if $verbose;

my $max = 0;

for @chars -> $char
{
  my $first  = $str.index($char);
  my $last   = $str.rindex($char);
  my $length = $last - $first - 1;
  my $is-max = $length > $max;
  
  say ":Char «$char» at pos $first and $last -> «{ $str.substr($first + 1, $length) }» with length $length { $is-max ?? "- new max" !! "" }" if $verbose;

  $max = $length if $is-max;
}

say $max;
