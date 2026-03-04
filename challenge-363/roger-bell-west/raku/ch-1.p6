#! /usr/bin/raku

use Test;

plan 5;

is(stringliedetector('aa - two vowels and zero consonants'), True, 'example 1');
is(stringliedetector('iv - one vowel and one consonant'), True, 'example 2');
is(stringliedetector('hello - three vowels and two consonants'), False, 'example 3');
is(stringliedetector('aeiou - five vowels and zero consonants'), True, 'example 4');
is(stringliedetector('aei - three vowels and zero consonants'), True, 'example 5');

sub stringliedetector($a) {
  my @words = $a.split(' ').grep({$_ ne ""});
  my $vowels = 0;
  my $consonants = 0;
  for @words[0].comb -> $c {
    if ($c ~~ /<[aeiou]>/) {
      $vowels++;
    } else {
      $consonants++;
    }
  }
  my %w2n = (
    "zero" => 0,
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9,
    "ten" => 10,
      );
  my $valid = True;
  my $mc = 0;
  for 2 .. @words.end -> $wi {
    my $w = @words[$wi];
    if (%w2n{$w}:exists) {
      $mc = %w2n{$w};
    } elsif ($w ~~ /^vowels?$/) {
      if ($mc != $vowels) {
        $valid = False;
      }
    } elsif ($w ~~ /^consonants?$/) {
      if ($mc != $consonants) {
        $valid = False;
      }
    }
    if (!$valid) {
      last;
    }
  }
  $valid;  
}
