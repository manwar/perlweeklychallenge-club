#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(brokenkeyboard('Hello World', ['d']), 1, 'example 1');
is(brokenkeyboard('apple banana cherry', ['a', 'e']), 0, 'example 2');
is(brokenkeyboard('Coding is fun', []), 3, 'example 3');
is(brokenkeyboard('The Weekly Challenge', ['a', 'b']), 2, 'example 4');
is(brokenkeyboard('Perl and Python', ['p']), 1, 'example 5');

sub brokenkeyboard($a, $b) {
  my %bk;
  foreach my $ch (@{$b}) {
    $bk{lc($ch)} = 1;
  }
  my $ct = 0;
  foreach my $w (split ' ', $a) {
    my %nk;
    foreach my $ch (split '', lc($w)) {
      $nk{$ch} = 1;
    }
    my @intersect = grep {exists $nk{$_}} keys %bk;
    if (scalar @intersect == 0) {
      $ct += 1;
    }
  }
  $ct;
}
