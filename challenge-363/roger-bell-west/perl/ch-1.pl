#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(stringliedetector('aa - two vowels and zero consonants'), 1, 'example 1');
is(stringliedetector('iv - one vowel and one consonant'), 1, 'example 2');
is(stringliedetector('hello - three vowels and two consonants'), 0, 'example 3');
is(stringliedetector('aeiou - five vowels and zero consonants'), 1, 'example 4');
is(stringliedetector('aei - three vowels and zero consonants'), 1, 'example 5');

sub stringliedetector($a) {
  my @words = split ' ', $a;
  my $vowels = 0;
  my $consonants = 0;
  foreach my $c (split '',$words[0]) {
    if ($c =~ /[aeiou]/) {
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
  my $valid = 1;
  my $mc = 0;
  foreach my $wi (2 .. $#words) {
    my $w = $words[$wi];
    if (exists $w2n{$w}) {
      $mc = $w2n{$w};
    } elsif ($w =~ /^vowels?$/) {
      if ($mc != $vowels) {
        $valid = 0;
      }
    } elsif ($w =~ /^consonants?$/) {
      if ($mc != $consonants) {
        $valid = 0;
      }
    }
    if (!$valid) {
      last;
    }
  }
  $valid;  
}
