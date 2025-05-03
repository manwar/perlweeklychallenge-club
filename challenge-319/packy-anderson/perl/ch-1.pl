#!/usr/bin/env perl
use v5.40;

my $vowels = qr{[aeiou]};

my $starts_or_ends_with_vowel = qr{
  \b $vowels # word boundry followed by a vowel
  |          # or
  $vowels \b # a vowel followed by a word boundry
}x;

sub wordCount(@list) {
  my @matched;
  foreach my $word (@list) {
    push @matched, $word
      if $word =~ /$starts_or_ends_with_vowel/;
  }
  return scalar(@matched);
}

sub solution($list) {
  say 'Input: @list = ("' . join('", "', @$list) . '")';
  say 'Output: ' . wordCount(@$list);
}

say "Example 1:";
solution(["unicode", "xml", "raku", "perl"]);

say "\nExample 2:";
solution(["the", "weekly", "challenge"]);

say "\nExample 3:";
solution(["perl", "python", "postgres"]);
