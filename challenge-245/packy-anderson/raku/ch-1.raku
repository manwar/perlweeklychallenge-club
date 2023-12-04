#!/usr/bin/env raku
use v6;

sub sortLanguage(@lang, @popularity) {
  # build a hash associating @popularity with @lang
  my %lang_pop = map {
    @lang[$_] => @popularity[$_]
  }, @lang.keys;
  my @sorted = @lang.sort({
    # sort by %lang_pop, not @lang
    %lang_pop{$^a} <=> %lang_pop{$^b}
  });
  return @sorted;
}

sub solution(@lang, @popularity) {
  say 'Input: @lang = (\'' ~ @lang.join('\', \'') ~ '\')';
  say '       @popularity = (' ~ @popularity.join(', ') ~ ')';
  my @output = sortLanguage(@lang, @popularity);
  say 'Output: (\'' ~ @output.join('\', \'') ~ '\')';
}

say "Example 1:";
solution(['perl', 'c', 'python'], [2, 1, 3]);

say "\nExample 2:";
solution(['c++', 'haskell', 'java'], [1, 3, 2]);
