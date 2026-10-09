#!/usr/bin/env perl
use v5.44;

use Set::Bag;

my $vowels     = qr/[aeiou]/;
my $consonants = qr/(?[ [a-z] & [^aeiou] ])/;

sub isAlternating($s) {
  $s =~ /^(?: $vowels?    (?: $consonants $vowels )+ |
              $consonants?(?: $vowels $consonants )+ )$/x;
}

sub altSubstrings($s) {
  my %substrings;
  for my $i (0..length($s)-1) {
    for my $j (reverse 2 .. length($s)-$i) {
      my $sub = substr($s, $i, $j);
      $substrings{$sub} = 1 if isAlternating($sub);
    }
  }
  Set::Bag->new(%substrings);
}

sub lcs(@arr) {
  my $bag = altSubstrings(shift @arr);
  $bag &= altSubstrings($_) for @arr;
  my ($longest) = sort {length($b)<=>length($a)} $bag->elements;
  sort grep { length($_) == length($longest)} $bag->elements;
}

sub quote_join(@list) {
  join ', ', map { qq/"$_"/ } @list;
}

sub solution($arr) {
  say 'Input: @arr = (' . quote_join(@$arr) . ')';
  say 'Output: (' . quote_join(lcs(@$arr)) . ')';
}

say "Example 1:";
solution(["relocate", "delocate", "allocate"]);

say "\nExample 2:";
solution(["apple", "banana", "cherry"]);

say "\nExample 3:";
solution(["navigate", "cavity", "gravity"]);

say "\nExample 4:";
solution(["pedalgia", "pedalboard", "pedantic"]);

say "\nExample 5:";
solution(["schoolmaster", "schoolhouse", "schooling"]);
