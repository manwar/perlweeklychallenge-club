#!/usr/bin/env perl
use v5.38;

sub sortLanguage{
  my ($lang, $popularity) = @_;
  # build a hash associating @popularity with @lang
  my %lang_pop = map {
    $lang->[$_] => $popularity->[$_]
  } 0 .. $#{$lang};
  my @sorted = sort {
    # sort by %lang_pop, not @$lang
    $lang_pop{$a} <=> $lang_pop{$b}
  } @$lang;
  return @sorted;
}

sub solution {
  my ($lang, $popularity) = @_;
  say 'Input: @lang = (\'' . join('\', \'', @$lang) . '\')';
  say '       @popularity = (' . join(', ', @$popularity) . ')';
  my @output = sortLanguage($lang, $popularity);
  say 'Output: (\'' . join('\', \'', @output) . '\')';
}

say "Example 1:";
solution(['perl', 'c', 'python'], [2, 1, 3]);

say "\nExample 2:";
solution(['c++', 'haskell', 'java'], [1, 3, 2]);
