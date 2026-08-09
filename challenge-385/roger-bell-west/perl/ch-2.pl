#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(outermostparentheses('()()()'), '', 'example 1');
is(outermostparentheses('(((())))'), '((()))', 'example 2');
is(outermostparentheses('(()())(())'), '()()()', 'example 3');
is(outermostparentheses('()((()))()'), '(())', 'example 4');
is(outermostparentheses('(()(()))(()())'), '()(())()()', 'example 5');

sub outermostparentheses($a) {
  my $d = 0;
  my $out = '';
  foreach my $c (split '', $a) {
    if ($c eq '(') {
      $d++;
      if ($d > 1) {
        $out .= $c;
      }
    } elsif ($c eq ')') {
      $d--;
      if ($d > 0) {
        $out .= $c;
      }
    } else {
      die "Bad char $c\n";
    }
  }
  $out;
}
