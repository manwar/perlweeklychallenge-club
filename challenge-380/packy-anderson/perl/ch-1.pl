#!/usr/bin/env perl
use v5.40;

use List::AllUtils  qw( max );
use List::MoreUtils qw( frequency );

sub sumFrequencies($str) {
  my %vowels     = frequency $str =~ / [aeiou]/gx;
  my %consonants = frequency $str =~ /[^aeiou]/gx;
  my $max_vowel     = max(values(%vowels), 0);
  my $max_consonant = max(values(%consonants), 0);
  return $max_vowel + $max_consonant;
}

sub solution($str) {
  say 'Input: $str = "' . $str . '"';
  say 'Output: ' . sumFrequencies($str);
}

say "Example 1:";
solution("banana");

say "\nExample 2:";
solution("teestett");

say "\nExample 3:";
solution("aeiouuaa");

say "\nExample 4:";
solution("rhythm");

say "\nExample 5:";
solution("x");
