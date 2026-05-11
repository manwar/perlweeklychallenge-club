#!/usr/bin/env raku
use v6;

sub largest($str) {
  my $max = 0;
  my @explain;
  my @chars = $str.comb.Bag.pairs
            .grep({ .value > 1 }) # filter out single chars
            .map({ .key });       # return just the chars
  for @chars -> $c {
    $str ~~ /$c (.*) $c/;
    $max = max($max, $0.chars);
    @explain.push(
      qq[For character "$c", we have substring "$0".]
    );
  }
  $max ~ "\n\n" ~ @explain.join("\n")
}

sub solution($str) {
  say qq[Input: \$str = "$str"];
  say qq[Output: {largest($str)}];
}

say "Example 1:";
solution("aaaaa");

say "\nExample 2:";
solution("abcdeba");

say "\nExample 3:";
solution("abbc");

say "\nExample 4:";
solution("abcaacbc");

say "\nExample 5:";
solution("laptop");
