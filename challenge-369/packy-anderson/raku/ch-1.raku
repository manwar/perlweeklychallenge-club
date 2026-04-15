#!/usr/bin/env raku
use v6;

sub validTag($caption) {
  '#' ~ $caption.subst(/<-[a..zA..Z\s]>/,:g)
                .split(/\s+/, :skip-empty)
                .pairs
                .map({ .key ?? .value.tclc !! .value.lc })
                .join
                .substr(0..98);
}

sub solution($caption) {
  say qq/Input: \$caption = "$caption"/;
  say qq/Output: "{validTag($caption)}"/;
}

say "Example 1:";
solution("Cooking with 5 ingredients!");

say "\nExample 2:";
solution("the-last-of-the-mohicans");

say "\nExample 3:";
solution("  extra spaces here");

say "\nExample 4:";
solution("iPhone 15 Pro Max Review");

say "\nExample 5:";
solution("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!");
