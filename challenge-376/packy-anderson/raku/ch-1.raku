#!/usr/bin/env raku
use v6;

sub isBlack($c) {
  my ($col, $row) = ($c.substr(0..0), $c.substr(1..1));
  ($col ~~ /<[aceg]>/ && $row % 2 == 1) ||
  ($col ~~ /<[bdfh]>/ && $row % 2 == 0) ?? 1 !! 0;
}

sub chessboardSquares($c1, $c2) {
  isBlack($c1) == isBlack($c2) ?? 'true' !! 'false';
}

sub solution($c1, $c2) {
  say qq/Input: \$c1 = "$c1", \$c2 = "$c2"/;
  say 'Output: ' ~ chessboardSquares($c1, $c2);
}

say "Example 1:";
solution("a7", "f4");

say "\nExample 2:";
solution("c1", "e8");

say "\nExample 3:";
solution("b5", "h2");

say "\nExample 4:";
solution("f3", "h1");

say "\nExample 5:";
solution("a1", "g8");
