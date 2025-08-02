#!/usr/bin/env perl
use v5.40;

my $startsWithVowel = qr/ ^[aeiou] /ix;

sub goatLatin($sentence) {
  my @words = split /\s+/, $sentence;
  my $a_count = 1;
  foreach my $word ( @words ) {
    if ($word =~ /$startsWithVowel/) {
      $word .= 'ma';
    }
    else {
      my $first = substr($word, 0, 1);
      my $rest  = substr($word, 1);
      $word = $rest . $first . 'ma';
    }
    $word .= 'a' x $a_count++;
  }
  return join(' ', @words);
}

sub solution($sentence) {
  say 'Input: $sentence = "' . $sentence . '"';
  say 'Output: "' . goatLatin($sentence) . '"';
}

say "Example 1:";
solution("I love Perl");

say "\nExample 2:";
solution("Perl and Raku are friends");

say "\nExample 3:";
solution("The Weekly Challenge");

say "\nExample 4:";
solution("Bus stop Bus goes She stays Love grows Under my umbrella");

