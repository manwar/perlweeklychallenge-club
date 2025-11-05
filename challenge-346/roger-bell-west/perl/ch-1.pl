#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(longestparenthesis('(()())'), 6, 'example 1');
is(longestparenthesis(')()())'), 4, 'example 2');
is(longestparenthesis('((()))()(((()'), 8, 'example 3');
is(longestparenthesis('))))((()('), 2, 'example 4');
is(longestparenthesis('()(()'), 2, 'example 5');

use List::Util qw(max);

sub longestparenthesis($aa) {
  my @a = split '', $aa;
  my $ml = 0;
  foreach my $l (0 .. $#a) {
    foreach my $r ($l .. $#a) {
      my $depth = 0;
      my $valid = 1;
      foreach my $i ($l .. $r) {
        if ($a[$i] eq '(') {
          $depth++;
        } else {
          $depth--;
          if ($depth < 0) {
            $valid = 0;
            last;
          }
        }
      }
      if ($depth != 0) {
        $valid = 0;
      }
      if ($valid) {
        $ml = max($ml, $r - $l + 1);
      }
    }
  }
  $ml;
}
