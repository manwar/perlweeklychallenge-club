#!/usr/bin/env perl
use v5.40;

sub sortString($str) {
  my %words;
  foreach my $w ( split /\s+/, $str ) {
    $w ~~ / (?<word>\D+) (?<order>\d+) /x;
    $words{$+{order}} = $+{word};
  }
  return join q{ }, map {
    $words{$_}
  } sort { $a <=> $b } keys %words;
}

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: "' . sortString($str) . '"';
}

say "Example 1:";
solution("and2 Raku3 cousins5 Perl1 are4");

say "\nExample 2:";
solution("guest6 Python1 most4 the3 popular5 is2 language7");

say "\nExample 3:";
solution("Challenge3 The1 Weekly2");

say "\nExample 4:";
solution("The1 brown9 dog10 fox4 jumped5 lazy8 over6 quick2 red3 the7");
