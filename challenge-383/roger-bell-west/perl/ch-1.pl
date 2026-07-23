#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(similarlist(['great', 'acting'], ['fine', 'drama'], [['great', 'fine'], ['acting', 'drama']]), 1, 'example 1');
is(similarlist(['apple', 'pie'], ['banana', 'pie'], [['apple', 'peach'], ['peach', 'banana']]), 0, 'example 2');
is(similarlist(['perl4', 'python'], ['raku', 'python'], [['perl4', 'perl5', 'raku']]), 1, 'example 3');
is(similarlist(['enjoy', 'challenge'], ['love', 'weekly', 'challenge'], [['enjoy', 'love']]), 0, 'example 4');
is(similarlist(['fast', 'car'], ['quick', 'vehicle'], [['quick', 'fast'], ['vehicle', 'car']]), 1, 'example 5');

sub similarlist($a, $b, $similar) {
  my %simmap;
  foreach my $simset (@{$similar}) {
    my $base = $simset->[0];
    foreach my $vn (1 .. $#{$simset}) {
      $simmap{$simset->[$vn]} = $base;
    }
  }
  foreach my $i (0 .. $#{$a}) {
    my $aw = $simmap{$a->[$i]} || $a->[$i];
    my $bw = $simmap{$b->[$i]} || $b->[$i];
    if ($aw ne $bw) {
      return 0;
    }
  }
  1;
}
