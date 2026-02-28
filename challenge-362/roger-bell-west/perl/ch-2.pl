#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(spellboundsorting([6, 7, 8, 9, 10]), [8, 9, 7, 6, 10], 'example 1');
is_deeply(spellboundsorting([-3, 0, 1000, 99]), [-3, 99, 1000, 0], 'example 2');
is_deeply(spellboundsorting([1, 2, 3, 4, 5]), [5, 4, 1, 3, 2], 'example 3');
is_deeply(spellboundsorting([0, -1, -2, -3, -4]), [-4, -1, -3, -2, 0], 'example 4');
is_deeply(spellboundsorting([100, 101, 102]), [100, 101, 102], 'example 5');

sub spellboundsorting($a) {
  my @o = @{$a};
  my @ow = map {towords($_)} @o;
  my @i = sort {$ow[$::a] cmp $ow[$::b]} (0 .. $#o);
  [map {$o[$_]} @i];
}

sub towords($a) {
  if ($a == 0) {
    return 'zero';
  }
  my @components;
  my $b = $a;
  if ($a < 0) {
    $b = -$a;
    push @components, "minus";
  }
  my $vw = [
        [1000000000, "milliard"],
        [1000000, "million"],
        [1000, "thousand"],
        [100, "hundred"],
        [90, "ninety"],
        [80, "eighty"],
        [70, "seventy"],
        [60, "sixty"],
        [50, "fifty"],
        [40, "forty"],
        [30, "thirty"],
        [20, "twenty"],
        [19, "nineteen"],
        [18, "eighteen"],
        [17, "seventeen"],
        [16, "sixteen"],
        [15, "fifteen"],
        [14, "fourteen"],
        [13, "thirteen"],
        [12, "twelve"],
        [11, "eleven"],
        [10, "ten"],
        [9, "nine"],
        [8, "eight"],
        [7, "seven"],
        [6, "six"],
        [5, "five"],
        [4, "four"],
        [3, "three"],
        [2, "two"],
        [1, "one"],
          ];
  foreach my $w (@{cw($b, $vw)}) {
    push @components, $w;
  }
  join(' ', @components);
}

sub cw($n, $vw) {
  my @res = ();
  foreach my $vx (@{$vw}) {
    (my $val, my $word) = @{$vx};
    if ($n >= $val) {
      my $andflag = 0;
      if ($n >= 100) {
        $andflag = 1;
        foreach my $w (@{cw(int($n / $val), $vw)}) {
          push @res, $w;
        }
      }
      push @res, $word;
      my $p = $n % $val;
      if ($p > 0) {
        if ($andflag) {
          push @res, "and";
        }
        foreach my $w (@{cw($p, $vw)}) {
          push @res, $w;
        }
      }
      last;
    }
  }
  \@res;
}
