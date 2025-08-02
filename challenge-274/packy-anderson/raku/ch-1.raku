#!/usr/bin/env raku
use v6;

my $startsWithVowel = rx/ :i ^<[aeiou]> /;

sub goatLatin($sentence) {
  my @words = $sentence.comb(/\S+/);
  my $a_count = 1;
  for @words <-> $word {
    if ($word ~~ $startsWithVowel) {
      $word ~= 'ma';
    }
    else {
      my $first = $word.substr(0,1);
      my $rest  = $word.substr(1);
      $word = $rest ~ $first ~ 'ma';
    }
    $word ~= 'a' x $a_count++;
  }
  return @words.join(' ');
}

sub solution($sentence) {
  say 'Input: $sentence = "' ~ $sentence ~ '"';
  say 'Output: "' ~ goatLatin($sentence) ~ '"';
}

say "Example 1:";
solution("I love Perl");

say "\nExample 2:";
solution("Perl and Raku are friends");

say "\nExample 3:";
solution("The Weekly Challenge");

say "\nExample 4:";
solution("Bus stop Bus goes She stays Love grows Under my umbrella");
