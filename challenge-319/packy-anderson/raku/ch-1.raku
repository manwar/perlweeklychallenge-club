#!/usr/bin/env raku
use v6;

my regex vowels { <[aeiou]> };

my regex starts_or_ends_with_vowel {
  « <{&vowels}> # left word boundry followed by a vowel
  ||            # or
  <{&vowels}> » # a vowel followed by the right word boundry
};

sub wordCount(@list) {
  my @matched;
  for @list -> $word {
    @matched.push($word) if $word ~~ &starts_or_ends_with_vowel;
  }
  return @matched.elems;
}

sub solution(@list) {
  say 'Input: @list = ("' ~ @list.join('", "') ~ '")';
  say 'Output: ' ~ wordCount(@list);
}

say "Example 1:";
solution(["unicode", "xml", "raku", "perl"]);

say "\nExample 2:";
solution(["the", "weekly", "challenge"]);

say "\nExample 3:";
solution(["perl", "python", "postgres"]);
