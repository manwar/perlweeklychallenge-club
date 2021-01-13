#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say state/;
use experimental qw/postderef/;
use List::Util qw/sum any/;

# Could use Algorithm::Combinatorics or Math::Combinatorics here...



BEGIN {
  eval {
    require Bit::Fast;
    Bit::Fast->import(qw/popcount/);
    1;
  } or eval {
    sub popcount {
      my $binary = unpack "b*", pack("i", $_[0]);
      return $binary =~ tr/1/1/;
    }
  };

  # Optionally use Algorithm::Combinatorics
  eval {
    require Algorithm::Combinatorics;
    Algorithm::Combinatorics->import(qw/combinations/);
    1;
  } or eval {
    sub combinations {
        state %cache;
        my ($items, $r) = @_;
        my $n = @$items;
        if (!exists $cache{$n}->{$r}) {
          my $max = (1 << $n) - 1;
          for my $c (grep { popcount($_) == $r } 1 .. $max) {
            push @{$cache{$n}->{$r}}, [ grep { $c & (1 << $_) } 0 .. $n - 1 ];
          }
        }
        return map { [ $items->@[@$_] ] } $cache{$n}->{$r}->@*;
      }
  }
}


sub task1 {
  if (any { my $total = sum @$_; 1 < $total && $total < 2 } combinations(\@_, 3)) {
    say 1;
  } else {
    say 0;
  }
}

task1(1.2, 0.4, 0.1, 2.5);
task1(0.2, 1.5, 0.9, 1.1);
task1(0.5, 1.1, 0.3, 0.7);
