#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(convertpalindrome('pinnipeds'), 'sdepinnipeds', 'example 1');
is(convertpalindrome('abcd'), 'dcbabcd', 'example 2');
is(convertpalindrome('bananas'), 'sananabananas', 'example 3');
is(convertpalindrome('dissident'), 'tnedissident', 'example 4');
is(convertpalindrome('cailliachs'), 'shcailliachs', 'example 5');

sub is_palindrome($a) {
  my $l = scalar @{$a};
  foreach my $i (0 .. int($l / 2)) {
    if ($a->[$i] ne $a->[$l - $i - 1]) {
      return 0;
    }
  }
  1;
}

sub convertpalindrome($a) {
  my @c0 = split '', $a;
  my $i = 0;
  while (1) {
    my @c = @c0;
    foreach my $n (0 .. $i - 1) {
      unshift @c, $c0[scalar @c0 - $i + $n];
    }
    if (is_palindrome(\@c)) {
      return join('', @c);
    }
    $i += 1;
  }
}
