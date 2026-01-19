#!/usr/bin/env raku
use v6;

sub tuple_to_fraction(@t) { @t[0] / @t[1] }

multi fractions($int where $int == 1) { [ (1, 1), ] }
multi fractions($int) {
  my @list   = [ (1, $int), ($int, 1) ];
  my @digits = $int == 2 ?? [ 2 ] !! 2 .. $int-1;
  for @digits -> $digit {
    next unless $int % $digit != 0;
    @list.append( ($int, $digit), ($digit, $int));                      
  }
  @list.append(fractions($int - 1));
}

sub uniqFractions($int) {
  fractions($int)
  .sort(&tuple_to_fraction)
  .map({ $_.join('/') }) # join the tuple with /
  .join(", ");
}

sub solution($int) {
  say qq/Input: \$int = $int/;
  say qq/Output: {uniqFractions($int)}/;
}

say "Example 1:";
solution(3);

say "\nExample 2:";
solution(4);

say "\nExample 3:";
solution(1);

say "\nExample 4:";
solution(6);

say "\nExample 5:";
solution(5);
