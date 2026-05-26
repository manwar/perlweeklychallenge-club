#!/usr/bin/env raku
use v6;

sub k_beauty($num, $k) {
  my $count = 0;
  for 0..($num.Str.chars - $k) -> $i {
    $count++ if $num.Int mod $num.Str.substr($i, $k).Int == 0;
  }
  $count;
}

sub solution($num, $k) {
  say qq/Input: \$num = $num, \$k = $k/;
  say 'Output: ' ~ k_beauty($num, $k);
}

say "Example 1:";
solution(240, 2);

say "\nExample 2:";
solution(1020, 2);

say "\nExample 3:";
solution(444, 2);

say "\nExample 4:";
solution(17, 2);

say "\nExample 5:";
solution(123, 1);
