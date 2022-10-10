#!/usr/bin/env raku


my @list-strings <==
  prompt '@list = ' andthen
  .comb: / "'" <( .*? )> "'" /;

dd @list-strings;

my @digits;
my @letters;

for @list-strings {
  m/ [' '? [$<letter>=<[a..z]>|$<digit>=<[0..9]>]]* /;
  @digits.push: $<digit>>>.Int if $<digit>;
  @letters.push: $<letter>>>.Str if $<letter>;
}

say "@digits.raku() and @letters.raku().trans('"' => '\'')";