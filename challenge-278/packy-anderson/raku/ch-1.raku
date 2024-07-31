#!/usr/bin/env raku
use v6;

sub sortString($str) {
  my %words;
  for $str.comb(/\S+/) -> $w {
    $w ~~ / $<word> = (\D+) $<order> = (\d+) /;
    %words{~$<order>} = ~$<word>;
  }
  return %words.sort(*.key.Int)>>.values.join(q{ });
}

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: "' ~ sortString($str) ~ '"';
}

say "Example 1:";
solution("and2 Raku3 cousins5 Perl1 are4");

say "\nExample 2:";
solution("guest6 Python1 most4 the3 popular5 is2 language7");

say "\nExample 3:";
solution("Challenge3 The1 Weekly2");

say "\nExample 4:";
solution("The1 brown9 dog10 fox4 jumped5 lazy8 over6 quick2 red3 the7");
