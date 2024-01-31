#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(reversevowels('Raku'), 'Ruka', 'example 1');
is(reversevowels('Perl'), 'Perl', 'example 2');
is(reversevowels('Julia'), 'Jaliu', 'example 3');
is(reversevowels('Uiua'), 'Auiu', 'example 4');

sub is_vowel($c) {
  if ($c =~ /[aeiou]/i) {
    return 1;
  } else {
    return 0;
  }
}

sub reversevowels($a) {
  my @p = split('', $a);
  my @q = grep {is_vowel($_)} @p;
  my $qi = scalar @q;
  my @o;
  foreach my $c (@p) {
    if (is_vowel($c)) {
      $qi--;
      my $nc = $q[$qi];
      if ($c eq uc($c)) {
        $nc = uc($nc);
      } else {
        $nc = lc($nc);
      }
      push @o, $nc;
    } else {
      push @o, $c;
    }
  }
  return join('', @o);
}
